import OSLog
import SwiftUI
import UnityHubCommon
import UnityHubStorage
import UserIcon

struct ProjectListItem: View {
	@Environment(\.projectInfoVisibility) private var infoVisibility
	@Environment(\.openProject) private var openProject

	@State private var isHovering: Bool = false
	@State private var isPresentingDetails: Bool = false

	@Binding private var project: ProjectMetadata

	init(_ project: Binding<ProjectMetadata>) {
		_project = project
	}

	var body: some View {
		content
			.padding(4)
			.frame(minHeight: 24)
			.onHover { value in
				withAnimation(.interactiveSpring) {
					isHovering = value
				}
			}
			.contextMenu {
				contextMenu
			}
			.sheet(isPresented: $isPresentingDetails) {
				ProjectInfoView($project)
			}
	}
}

// MARK: - Supporting Views

private extension ProjectListItem {
	var content: some View {
		HStack {
			Button(action: openProjectAction) {
				HStack {
					projectIcon

					VStack(alignment: .leading, spacing: 2) {
						projectName

						projectPath
							.font(.caption)
							.foregroundStyle(.secondary)
							.monospaced()
							.controlSize(.mini)
					}

					Spacer()
				}
				.contentShape(.rect)
			}
			.buttonStyle(.plain)

			editorVersion
		}
	}

	@ViewBuilder var projectIcon: some View {
		if infoVisibility.contains(.icon) {
			Group {
				if project.icon != .blank {
					UserIconView(project.icon)
				} else {
					Color.clear
				}
			}
			.aspectRatio(1, contentMode: .fit)
			.frame(height: 32)
		}
	}

	var projectName: some View {
		HStack(spacing: 0) {
			if project.pinned {
				Image(systemName: "pin")
					.symbolVariant(.fill)
					.foregroundStyle(.orange)
					.scaleEffect(0.7)
					.rotationEffect(.degrees(-45))
					.offset(y: 1)
			}

			Text(project.name)
				.font(.headline)
		}
	}

	@ViewBuilder var projectPath: some View {
		if infoVisibility.contains(.location) {
			Text(project.url.abbreviatingWithTildeInPath)
		}
	}

	@ViewBuilder var editorVersion: some View {
		if
			infoVisibility.contains(.editorVersion),
			let editorVersion = project.editorVersion
		{
			UnityEditorVersionView(editorVersion)
		}
	}
}

// MARK: - Context Menu

private extension ProjectListItem {
	@ViewBuilder var contextMenu: some View {
		Section {
			Button("Details", systemImage: "info") { isPresentingDetails = true }
				.keyboardShortcut("i")
		}

		Section {
			Button("Show in Finder", action: project.url.showInFinder)
		}

		Section {
			Button("Remove", systemImage: "trash", role: .destructive, action: removeProjectAction)
				.keyboardShortcut(.delete)
		}
	}
}

// MARK: - Functions

private extension ProjectListItem {
	func removeProjectAction() {
		ProjectCache.shared.removeProject(at: project.url)
	}

	func openProjectAction() {
		do {
			try openProject(project.url)
		} catch let OpenProjectActionError.missingRequiredObject(objectType) {
			preconditionFailure(missingObject: objectType)
		} catch {
			Logger.module.debug("""
			Failed to complete \(#function):
			\(error.localizedDescription)
			""")
		}
	}
}
