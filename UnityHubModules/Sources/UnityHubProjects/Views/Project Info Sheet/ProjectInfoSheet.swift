import SwiftUI
import UnityHubCommon
import UnityHubStorage
import UserIcon

struct ProjectInfoSheet: View {
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

private extension ProjectInfoSheet {
	@ViewBuilder var formContent: some View {
		Section {
			LocationLabel(project.url)
			FileSizeLabel(at: project.url)
		}

		Section {
			EditorVersionLabel(project.editorVersion)
			LabeledContent("Name", value: project.name ?? project.url.lastPathComponent)
			LabeledContent("Developer", value: project.developer ?? "Unknown")
		}
	}
}
