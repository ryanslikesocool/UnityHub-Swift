import SwiftUI
import UnityHubCommon
import UnityHubProjectStorage
import UnityHubSettingsStorage
import UserIcon

struct ProjectDetails: View {
	@Binding private var project: ProjectInfo

	init(_ project: Binding<ProjectInfo>) {
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

private extension ProjectDetails {
	@ViewBuilder var formContent: some View {
		Section {
			LocationLabel(project.url)
			EditorVersionLabel(project.editorVersion)
			FileSizeLabel(project: project)
		}

		Section {
			LabeledContent("Name", value: "Unknown")
			LabeledContent("Developer", value: "Unknown")
		}
	}
}
