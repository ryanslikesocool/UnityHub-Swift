import OSLog
import SwiftUI
import UnityHubProjectStorage
import UnityHubSettingsStorage

@Observable
final class ProjectListState {
	static let shared: ProjectListState = ProjectListState()

	var projects: [URL: ProjectInfo]
	var projectEditorVersions: [UnityEditorVersion] { Set(projects.values.compactMap { $0.editorVersion }).sorted() }

	private var fileSizeTasks: [URL?: Task<Void, Never>]

	init() {
		projects = [:]
		fileSizeTasks = [:]

		addProjects(in: AppSettings.shared.projects.projectMetadata)
	}
}

extension ProjectListState {
	func refreshProjects() {
		let newProjects = AppSettings.shared.projects.projectMetadata
			.filter { !projects.keys.contains($0.url) }

		for newProject in newProjects {
			projects[newProject.url] = ProjectInfo(user: newProject)
		}

		recalculateFileSizes(for: newProjects.map(\.url))
	}

	func addProjects(in collection: some Sequence<ProjectUserMetadata>, recalculateFileSizes: Bool = true) {
		for metadata in collection {
			addProject(metadata, recalculateFileSize: false)
		}
		if recalculateFileSizes {
			self.recalculateFileSizes(for: collection.map(\.url))
		}
	}

	func addProject(_ metadata: ProjectUserMetadata, recalculateFileSize: Bool = true) {
		defer {
			if recalculateFileSize {
				self.recalculateFileSize(for: metadata.url)
			}
		}

		guard !projects.keys.contains(metadata.url) else {
			return
		}
		projects[metadata.url] = ProjectInfo(user: metadata)
	}

	func removeProject(at url: URL) {
		fileSizeTasks[url]?.cancel()
		fileSizeTasks[url] = nil

		projects[url] = nil
	}
}

// MARK: - Tasks

extension ProjectListState {
	func isRunningFileSizeTask(for url: URL) -> Bool {
		fileSizeTasks.keys.contains(url) || fileSizeTasks.keys.contains(nil)
	}

	func cancelFileSizeTask(_ url: URL?) {
		guard let task = fileSizeTasks.removeValue(forKey: url) else {
			return
		}
		task.cancel()
	}

	func cancelFileSizeTasks() {
		if let multiple = fileSizeTasks[nil] {
			multiple.cancel()
		} else {
			for task in fileSizeTasks.values {
				task.cancel()
			}
		}
		fileSizeTasks.removeAll()
	}

	func cancelFileSizeTasks(for collection: some Sequence<URL?>) {
		for url in collection {
			cancelFileSizeTask(url)
		}
	}

	func cancelFileSizeTasks(for collection: some Sequence<URL>) {
		for url in collection {
			cancelFileSizeTask(url)
		}
	}

	func recalculateFileSize(for url: URL) {
		cancelFileSizeTask(url)

		fileSizeTasks[url] = Task { @MainActor in
			let newFileSize: String?
			do {
				newFileSize = try url.sizeOnDisk()
			} catch {
				Logger.module.error("""
				Failed to calculate file size for \(url.path(percentEncoded: false)):
				\(error.localizedDescription)
				""")

				newFileSize = nil
			}

			await MainActor.run {
				fileSizeTasks.removeValue(forKey: url)

				projects[url]?.fileSize = newFileSize

				Logger.module.debug("Finished recalculating file size for the project at \(url.path(percentEncoded: false)) with result \(String(describing: newFileSize)).")
			}
		}
	}

	func recalculateFileSizes(for urls: some Sequence<URL>) {
		cancelFileSizeTasks(for: urls)
		cancelFileSizeTask(nil)

		fileSizeTasks[nil] = Task {
			do {
				let newFileSize: [(URL, String?)] = try await withThrowingTaskGroup(of: (URL, String?).self) { taskGroup in
					for key in urls {
						taskGroup.addTask {
							try (key, key.sizeOnDisk())
						}

						if Task.isCancelled {
							break
						}
					}

					return try await taskGroup.reduce()
				}

				await MainActor.run {
					fileSizeTasks.removeAll()

					for (url, size) in newFileSize {
						projects[url]?.fileSize = size
					}

					if !Task.isCancelled {
						Logger.module.debug("Finished recalculating multiple project file sizes.")
					}
				}
			} catch {
				Logger.module.error("""
				Failed to recalculate project file sizes:
				\(error.localizedDescription)
				""")
			}
		}

		for url in urls {
			fileSizeTasks[url] = fileSizeTasks[nil]
		}
	}

	func recalculateFileSizes() {
		recalculateFileSizes(for: projects.keys)
	}
}
