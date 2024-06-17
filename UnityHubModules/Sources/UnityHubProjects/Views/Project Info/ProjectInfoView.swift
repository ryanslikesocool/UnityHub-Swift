import SwiftUI
import UnityHubCommon
import UnityHubStorage
import UserIcon

struct ProjectInfoView: View {
	@Environment(\.dismiss) private var dismiss

	@Binding private var project: ProjectMetadata

	init(_ project: Binding<ProjectMetadata>) {
		_project = project
	}

	var body: some View {
		Form {
			formContent
		}
		.formStyle(.grouped)
		.scrollDisabled(true)
		.toolbar {
			Toolbar(project: $project)
		}
	}
}

// MARK: - Supporting Views

private extension ProjectInfoView {
	@ViewBuilder var formContent: some View {
		Section {
			LocationLabel(project.url)
			EditorVersionLabel(project.editorVersion)
			FileSizeLabel(at: project.url)
		}

		Section {
			LabeledContent("Name", value: project.name)
			LabeledContent("Developer", value: project.developer ?? "Unknown")
		}
	}
}
