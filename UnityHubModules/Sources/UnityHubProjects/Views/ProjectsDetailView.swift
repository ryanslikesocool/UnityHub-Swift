import SwiftUI
import UnityHubProjectStorage
import UnityHubSettingsStorage

public struct ProjectsDetailView: View {
	@Bindable private var appSettings: AppSettings = .shared
	@Bindable private var projectListState: ProjectListState = .shared

	public init() { }

	public var body: some View {
		ProjectList()
			.toolbar {
				AddProjectButton()
				ProjectInfoVisibilityMenu(selection: $appSettings.projects.infoVisibility)
				SortMenu(criteria: $appSettings.projects.sortCriteria, order: $appSettings.projects.sortOrder)
			}

			.projectInfoVisibility(appSettings.projects.infoVisibility)
			.addProjectAction(appSettings: appSettings, projectListState: projectListState)
			.removeProjectAction(appSettings: appSettings, projectListState: projectListState)
			.isRunningFileSizeTaskAction(projectListState: projectListState)
			.recalcualteFileSize(projectListState: projectListState)
	}
}
