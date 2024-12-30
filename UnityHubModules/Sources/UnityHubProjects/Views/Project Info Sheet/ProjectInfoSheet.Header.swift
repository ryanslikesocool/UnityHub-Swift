import SwiftUI
import UnityHubStorageProjects

extension ProjectInfoSheet {
	struct Header: View {
		@Environment(\.dismiss) private var dismiss

		@Binding private var project: ProjectMetadata

		init(project: Binding<ProjectMetadata>) {
			_project = project
		}

		var body: some View {
			ProjectIcon(project: $project)
				.frame(height: 32)
				.padding([.bottom, .top], -8)

			Text(project.name ?? project.url.lastPathComponent)
				.font(.headline)

			Spacer()

			Button("Done", role: .cancel) { dismiss() }
				.controlSize(.large)
		}
	}
}
