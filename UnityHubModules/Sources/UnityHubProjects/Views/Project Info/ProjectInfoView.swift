import SwiftUI
import UnityHubCommon
import UnityHubProjectStorage
import UnityHubSettingsStorage
import UserIcon

struct ProjectInfoView: View {
	@Binding private var project: ProjectMetadata

	init(_ project: Binding<ProjectMetadata>) {
		_project = project
	}

	var body: some View {
		VStack(spacing: 0) {
			Header(project: $project)

			Divider()

			Form {
				formContent
			}
			.formStyle(.grouped)
			.scrollDisabled(true)
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
