import SwiftUI
import UnityHubCommonViews
import UnityHubStorage

extension ProjectList.Item {
	struct ButtonLabel: View {
		@Bindable private var appSettings: AppSettings = .shared
		
		@Binding private var project: ProjectMetadata

		init(_ project: Binding<ProjectMetadata>) {
			_project = project
		}

		var body: some View {
			HStack {
				Icon($project)

				VStack(alignment: .leading, spacing: 2) {
					projectName

					projectPath
				}

				Spacer()
			}
			.contentShape(.rect)
		}
	}
}

// MARK: - Supporting Views

private extension ProjectList.Item.ButtonLabel {
	var projectName: some View {
		HStack(spacing: 0) {
			if project.pinned {
				Image(systemName: "pin")
					.symbolVariant(.fill)
					.foregroundStyle(.orange)
					.scaleEffect(0.7)
					.rotationEffect(.degrees(-45))
					.offset(y: 1)
			}

			Text(project.name)
				.font(.headline)
		}
	}

	@ViewBuilder var projectPath: some View {
		if appSettings.projects.infoVisibility.contains(.location) {
			URLLabel(project.url)
				.lineLimit(1)
				.font(.caption)
				.foregroundStyle(.secondary)
		}
	}
}
