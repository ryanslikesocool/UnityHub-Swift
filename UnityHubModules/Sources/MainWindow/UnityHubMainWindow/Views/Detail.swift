import SwiftUI
import UnityHubMainWindowInstallations
import UnityHubMainWindowProjects
import UnityHubMainWindowResources

struct Detail: View {
	@Binding private var sidebarSelection: SidebarItem

	public init(
		sidebarSelection: Binding<SidebarItem>
	) {
		_sidebarSelection = sidebarSelection
	}

	public var body: some View {
		switch sidebarSelection {
			case .projects: ProjectsView()
			case .installations: InstallationsView()
			case .resources: ResourcesView()
		}
	}
}
