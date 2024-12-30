import SwiftUI
import UnityHubMainWindowInstallations
import UnityHubMainWindowProjects
import UnityHubMainWindowResources

struct Detail: View {
	@Binding var sidebarSelection: SidebarItem

	var body: some View {
		switch sidebarSelection {
			case .projects: ProjectsView()
			case .installations: InstallationsView()
			case .resources: ResourcesView()
		}
	}
}
