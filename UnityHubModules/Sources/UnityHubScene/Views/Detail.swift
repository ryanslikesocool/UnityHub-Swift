import SwiftUI
import UnityHubProjects

struct Detail: View {
	@Binding var sidebarSelection: SidebarItem

	var body: some View {
		switch sidebarSelection {
			case .projects: ProjectsView()
			case .installations: InstallationsDetailView()
			case .learn: LearnDetailView()
			case .community: CommunityDetailView()
		}
	}
}
