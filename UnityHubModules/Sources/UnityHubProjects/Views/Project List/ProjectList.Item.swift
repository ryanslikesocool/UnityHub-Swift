import OSLog
import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage
import UserIcon

extension ProjectList {
	struct Item: View {
		@AppSetting(project: \.infoVisibility) private var infoVisibility

		@Binding private var project: ProjectMetadata

		init(_ project: Binding<ProjectMetadata>) {
			_project = project
		}

		var body: some View {
			OpenProjectButton(at: project.url) {
				ListItem(content: labelContent, menu: contextMenu)
			}
			.buttonStyle(.plain)
			.contextMenu(menuItems: contextMenu)
			.swipeActions(edge: .leading, allowsFullSwipe: true) {
				Toggle(isOn: $project.pinned, label: Label.pin)
					.tint(.orange)
			}
			.onAppear { project.validateLazyData() }
		}
	}
}

// MARK: - Supporting Views

private extension ProjectList.Item {
	@ViewBuilder func labelContent() -> some View {
		let fileManager: FileManager = .default
		let exists: Bool = fileManager.directoryExists(at: project.url)

		if infoVisibility.contains(.icon) {
			Icon($project.icon)
				.onAppear { project.validateEmbeddedMetadata() }
		}

		Spacer()
			.frame(width: 8)

		VStack(alignment: .leading, spacing: 1) {
			NameLabel(project)

			if
				infoVisibility.contains(.location),
				exists
			{
				URLLabel(project.url)
					.urlLabelStyle(.listItem)
			}
		}

		Spacer()

		if exists {
			if infoVisibility.contains(.lastOpened) {
				LastOpenedLabel(date: project.lastOpened)
			}
			EditorVersionLabel(project.editorVersion)
		} else {
			MissingObjectButton {
				Event.missingProject(project.url)
			}
		}
	}

	private func contextMenu() -> some View {
		ContextMenu($project)
	}
}
