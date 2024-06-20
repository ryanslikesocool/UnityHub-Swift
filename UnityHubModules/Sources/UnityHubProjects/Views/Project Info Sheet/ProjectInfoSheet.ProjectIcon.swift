import SwiftUI
import UnityHubCommon
import UnityHubStorage
import UserIcon

extension ProjectInfoSheet {
	struct ProjectIcon: View {
		@Binding private var project: ProjectMetadata
		@State private var isPresentingSheet: Bool = false

		init(project: Binding<ProjectMetadata>) {
			_project = project
		}

		var body: some View {
			Button(action: { isPresentingSheet = true }) {
				if project.icon == .blank {
					Circle()
						.stroke(lineWidth: 1)
						.foregroundStyle(.separator)
						.overlay {
							Image(systemName: Constant.Symbol.plus)
								.foregroundStyle(.tertiary)
								.font(.title3)
						}
						.aspectRatio(1, contentMode: .fit)
				} else {
					UserIconView(project.icon)
				}
			}
			.buttonStyle(.plain)
			.scaledToFit()
			.sheet(isPresented: $isPresentingSheet) {
				UserIconEditor(selection: $project.icon)
					.userIconEditorStyle(.horizontalSheet)
			}
		}
	}
}
