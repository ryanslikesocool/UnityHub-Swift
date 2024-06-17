import OSLog
import SwiftUI
import UnityHubCommon
import UnityHubProjectStorage
import UnityHubSettingsStorage
import UserIcon

struct ProjectListItem: View {
	@Environment(\.projectInfoVisibility) private var infoVisibility
	@Environment(\.removeProject) private var removeProject

	@State private var isHovering: Bool = false
	@State private var isPresentingDetails: Bool = false

	@Binding private var project: ProjectInfo

	init(_ project: Binding<ProjectInfo>) {
		_project = project
	}

	var body: some View {
		content
			.padding(4)
			.frame(minHeight: 24)
			.onHover { value in isHovering = value }
			.contextMenu {
				contextMenu
			}
			.sheet(isPresented: $isPresentingDetails) {
				ProjectDetails($project)
			}
	}
}

// MARK: - Supporting Views

private extension ProjectListItem {
	var content: some View {
		HStack {
			projectIcon

			Button(action: {
				// TODO: implement
			}) {
				HStack {
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
			ProjectIconButton(project: $project) {
				Image(systemName: "plus")
					.frame(maxWidth: .infinity, maxHeight: .infinity)
					.foregroundStyle(.secondary)
					.font(.title)
					.overlay(.separator, in: .circle)
					.opacity(isHovering ? 1 : 0)
					.aspectRatio(1, contentMode: .fit)
			}
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
			Text(project.path)
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
		do {
			try removeProject(project.url)
		} catch let RemoveProjectActionError.missingRequiredObject(objectType) {
			preconditionFailure(missingObject: objectType)
		} catch {
			Logger.module.debug("""
			Failed to complete \(#function):
			\(error.localizedDescription)
			""")
		}
	}
}
