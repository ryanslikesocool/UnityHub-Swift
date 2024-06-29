import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage
import UserIcon

struct ProjectInfoSheet: View {
	@Binding private var project: ProjectMetadata

	init(_ project: Binding<ProjectMetadata>) {
		_project = project
	}

	var body: some View {
		Sheet {
			Form {
				formContent
			}
			.formStyle(.grouped)
			.scrollDisabled(true)
		} header: {
			Header(project: $project)
		}
	}
}

// MARK: - Supporting Views

private extension ProjectInfoSheet {
	@ViewBuilder var formContent: some View {
		Section {
			LabeledContent("Name", value: project.name ?? project.url.lastPathComponent)
			LabeledContent("Developer", value: project.developer ?? "Unknown")
			EditorVersionLabel(project.editorVersion)
		}

		Section {
			LocationLabel(project.url)
			FileSizeLabel(at: project.url)
		}
	}
}
