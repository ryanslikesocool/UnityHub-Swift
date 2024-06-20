import SwiftUI
import UnityHubStorage
import UnityHubCommonViews
import UnityHubCommon

extension ProjectList.Item{
	struct ContextMenu: View {
		@Binding private var project: ProjectMetadata

		init(_ project: Binding<ProjectMetadata>) {
			_project = project
		}

		var body: some View {
			Group {
				Section {
					Button.info {
						Event.displayInfoSheet(project.url)
					}

					Toggle(isOn: $project.pinned, label: Label.pin)

					Button.showInFinder(destination: project.url)
				}

				Section {
					Button(
						role: .destructive,
						action: {
							Event.removeProject(project.url)
						},
						label: Label.remove
					)
					.keyboardShortcut(.delete)
				}
			}
			.labelStyle(.titleAndIcon)
		}
	}
}
