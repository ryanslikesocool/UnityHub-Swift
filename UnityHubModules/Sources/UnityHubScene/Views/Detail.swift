import SwiftUI
import UnityHubProjects
import UnityHubInstallations

struct Detail: View {
	@Binding var sidebarSelection: SidebarItem

	var body: some View {
		switch sidebarSelection {
			case .projects: ProjectsView()
			case .installations: InstallationsView()
			case .learn: LearnDetailView()
			case .community: CommunityDetailView()
		}
	}
}
