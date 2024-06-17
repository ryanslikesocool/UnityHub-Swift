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
				ProjectIconButton(project: $project) {
					Circle()
						.stroke(lineWidth: 1)
						.foregroundStyle(.separator)
						.overlay {
							Image(systemName: "plus")
								.foregroundStyle(.tertiary)
								.font(.title3)
						}
						.aspectRatio(1, contentMode: .fit)
				}
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
