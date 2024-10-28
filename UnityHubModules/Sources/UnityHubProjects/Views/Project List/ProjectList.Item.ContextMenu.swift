import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

extension ProjectList.Item {
	struct ContextMenu: View {
		@CacheFile(InstallationCache.self) private var installations

		@Binding private var project: ProjectMetadata

		init(_ project: Binding<ProjectMetadata>) {
			_project = project
		}

		var body: some View {
			let fileManager: FileManager = .default

			Group {
				Section {
					let hasInstallationVersion: Bool = installations.installations.contains { installation in
						(try? installation.version) == project.editorVersion
					}

					ProjectList.OpenProjectButton(at: project.url, label: Label.open)
						.disabled(!hasInstallationVersion)

					ProjectList.OpenProjectWithVersionMenu(project: $project)
				}

				Section {
					InfoButton {
						Event.Project.displayInfo.send(project.url)
					}

					ProjectList.ProjectPinnedToggle(isOn: $project.pinned)

					ShowInFinderButton(project.url)
				}
			}
			.disabled(!fileManager.directoryExists(at: project.url))

			Section {
				ProjectList.RemoveProjectButton(at: project.url)
			}
		}
	}
}
