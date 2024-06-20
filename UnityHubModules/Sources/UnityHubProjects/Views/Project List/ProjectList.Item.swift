import OSLog
import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage
import UserIcon

extension ProjectList {
	struct Item: View {
		@Bindable private var appSettings: AppSettings = .shared
		@Bindable private var projectCache: ProjectCache = .shared

		@Binding private var project: ProjectMetadata

		init(_ project: Binding<ProjectMetadata>) {
			_project = project
		}

		var body: some View {
			Button(action: openProject) {
				ListItem(content: labelContent, menu: contextMenu)
			}
			.buttonStyle(.plain)
			.contextMenu(menuItems: contextMenu)
			.swipeActions(edge: .leading, allowsFullSwipe: true) {
				Toggle(isOn: $project.pinned, label: Label.pin)
					.tint(.orange)
			}
		}
	}
}

// MARK: - Supporting Views

private extension ProjectList.Item {
	@ViewBuilder func labelContent() -> some View {
		if appSettings.projects.infoVisibility.contains(.icon) {
			Icon($project.icon)
		}

		Spacer()
			.frame(width: 8)

		VStack(alignment: .leading, spacing: 1) {
			NameLabel(project)

			if appSettings.projects.infoVisibility.contains(.location) {
				URLLabel(project.url)
					.urlLabelStyle(.listItem)
			}
		}

		Spacer()

		if project.exists {
			if appSettings.projects.infoVisibility.contains(.lastOpened) {
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

// MARK: - Functions

private extension ProjectList.Item {
	func openProject() {
		do {
			try projectCache.openProject(at: project.url)
		} catch ProjectCache.ProjectError.invalid {
			Event.invalidProject()
		} catch {
			preconditionFailure("""
			Caught an unexpected error:
			\(error.localizedDescription)
			""")
		}
	}
}
