import SwiftUI
import UnityHubStorage

extension ProjectInfoView {
	struct Toolbar: ToolbarContent {
		@Environment(\.dismiss) private var dismiss

		@Binding private var project: ProjectMetadata

		init(project: Binding<ProjectMetadata>) {
			_project = project
		}

		var body: some ToolbarContent {
			ToolbarItemGroup {
				ProjectIcon(project: $project)
					.frame(height: 32)
					.padding([.leading, .bottom, .top], -8)

				Text(project.name)
					.font(.headline)
			}

			ToolbarItemGroup(placement: .cancellationAction) {
				Button("Done", role: .cancel) { dismiss() }
			}
		}
	}
}
