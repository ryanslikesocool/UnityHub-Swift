import SwiftUI
import UnityHubProjectStorage
import UnityHubSettingsStorage

public struct ProjectsView: View {
	@Bindable private var appSettings: AppSettings = .shared
	@Bindable private var projectCache: ProjectCache = .shared

	public init() { }

	public var body: some View {
		ProjectList()
			.toolbar {
				AddProjectButton()
				ProjectInfoVisibilityMenu(selection: $appSettings.projects.infoVisibility)
				SortMenu(criteria: $appSettings.projects.sortCriteria, order: $appSettings.projects.sortOrder)
			}

			.projectInfoVisibility(appSettings.projects.infoVisibility)
			.openProjectAction(appSettings: appSettings, projectCache: projectCache)
	}
}
