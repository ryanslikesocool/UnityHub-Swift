import SwiftUI
import UnityHubProjectStorage

extension ProjectInfoView {
	struct Header: View {
		@Environment(\.dismiss) private var dismiss

		@Binding private var project: ProjectMetadata

		init(project: Binding<ProjectMetadata>) {
			_project = project
		}

		var body: some View {
			HStack(spacing: 12) {
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
					.frame(height: 32)
				}
				.padding(-4)

				Text(project.name)
					.font(.title3.weight(.bold))

				Spacer()

				Button("Done", role: .cancel) { dismiss() }
					.controlSize(.large)
			}
			.padding()
		}
	}
}
