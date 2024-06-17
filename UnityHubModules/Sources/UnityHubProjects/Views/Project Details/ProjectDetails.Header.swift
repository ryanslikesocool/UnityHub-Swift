import SwiftUI
import UnityHubProjectStorage

extension ProjectDetails {
	struct Header: View {
		@Environment(\.dismiss) private var dismiss

		@Binding private var project: ProjectInfo

		init(project: Binding<ProjectInfo>) {
			_project = project
		}

		var body: some View {
			HStack {
				ProjectIconButton(project: $project)
					.frame(height: 32)

				Text(project.name)
					.font(.headline)

				Spacer()

				Button("Done", role: .cancel) { dismiss() }
			}
			.padding()
		}
	}
}
