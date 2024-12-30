import OSLog
import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorageInstallations
import UnityHubStorageProjects
import UnityHubStorageSettings
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
				ListItem(content: labelContent, menu: contextMenu, issue: issueMenu)
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
		if infoVisibility.contains(.icon) {
			Icon($project.icon)
				.onAppear { project.validateEmbeddedMetadata() }

			Spacer()
				.frame(width: 8)
		}

		VStack(alignment: .leading, spacing: 1) {
			NameLabel(project)

			if
				infoVisibility.contains(.location),
				project.directoryExists
			{
				URLLabel(project.url)
					.urlLabelStyle(.listItem)
			}
		}

		Spacer()

		if project.directoryExists {
			if infoVisibility.contains(.lastOpened) {
				LastOpenedLabel(date: project.lastOpened)

				Spacer()
					.frame(width: 16)
			}

			EditorVersionLabel(project.editorVersion)
		}
	}

	func contextMenu() -> some View {
		ContextMenu($project)
	}

	func issueMenu() -> some View {
		IssueMenu(
			projectURL: project.url,
			missingProject: !project.directoryExists,
			missingInstallation: !InstallationCache.shared.contains(project.editorVersion)
		)
	}
}
