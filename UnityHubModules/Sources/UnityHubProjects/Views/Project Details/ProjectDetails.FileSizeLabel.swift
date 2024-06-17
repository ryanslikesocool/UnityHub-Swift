import OSLog
import SwiftUI
import UnityHubCommon
import UnityHubProjectStorage
import UnityHubSettingsStorage
import UserIcon

extension ProjectDetails {
	struct FileSizeLabel: View {
		@Environment(\.isRunningFileSizeTask) private var isRunningFileSizeTask
		@Environment(\.recalculateFileSize) private var recalculateFileSize

		private let project: ProjectInfo

		private var isLoading: Bool {
			do {
				return try isRunningFileSizeTask(for: project.url)
			} catch let IsRunningFileSizeTaskActionError.missingRequiredObject(objectType) {
				preconditionFailure(missingObject: objectType)
			} catch {
				Logger.module.debug("""
				Failed to complete \(#function):
				\(error.localizedDescription)
				""")
				return false
			}
		}

		init(project: ProjectInfo) {
			self.project = project
		}

		var body: some View {
			LabeledContent("Size") {
				HStack(spacing: 4) {
					spinner
					fileSizeText
					recalculateButton
				}
			}
		}
	}
}

// MARK: - Supporting Views

private extension ProjectDetails.FileSizeLabel {
	@ViewBuilder var spinner: some View {
		if isLoading {
			ProgressView()
				.controlSize(.small)
		}
	}

	@ViewBuilder var fileSizeText: some View {
		if let fileSize = project.fileSize {
			Text(fileSize)
				.monospaced()
		} else if !isLoading {
			Button(action: recalculateFileSizeAction) {
				Image(systemName: "exclamationmark.triangle")
					.foregroundStyle(.yellow)
			}
			.buttonStyle(.plain)
			.help("Unknown file size.  Click to recalculate.")
		}
	}

	var recalculateButton: some View {
		Button("Recalculate", systemImage: "arrow.clockwise", action: recalculateFileSizeAction)
			.help("Recalculate")
			.labelStyle(.iconOnly)
			.controlSize(.small)
			.disabled(isLoading)
	}
}

// MARK: - Functions

private extension ProjectDetails.FileSizeLabel {
	func recalculateFileSizeAction() {
		do {
			try recalculateFileSize(for: project.url)
		} catch let RecalculateFileSizeActionError.missingRequiredObject(objectType) {
			preconditionFailure(missingObject: objectType)
		} catch {
			Logger.module.debug("""
			Failed to complete \(#function):
			\(error.localizedDescription)
			""")
		}
	}
}
