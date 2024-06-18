import SwiftUI
import UnityHubStorage
import UserIcon

extension ProjectList.Item {
	struct Icon: View {
		@Bindable private var appSettings: AppSettings = .shared

		@Binding private var project: ProjectMetadata

		init(_ project: Binding<ProjectMetadata>) {
			_project = project
		}

		var body: some View {
			Group {
				if project.exists {
					if appSettings.projects.infoVisibility.contains(.icon) {
						if project.icon != .blank {
							UserIconView(project.icon)
						} else {
							Color.clear
						}
					}
				} else {
					MissingIcon($project)
				}
			}
			.aspectRatio(1, contentMode: .fit)
			.frame(width: Self.size)
		}
	}
}

// MARK: - Constants

extension ProjectList.Item.Icon {
	static let size: CGFloat = 32
}
