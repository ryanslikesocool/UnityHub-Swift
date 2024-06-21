import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

extension ProjectList.Item {
	struct ContextMenu: View {
		@Cache(InstallationCache.self) private var installations

		@Binding private var project: ProjectMetadata

		init(_ project: Binding<ProjectMetadata>) {
			_project = project
		}

		var body: some View {
			Group {
				Section {
					let hasInstallationVersion: Bool = installations.installations.contains(where: { installation in
						installation.version == project.editorVersion
					})

					ProjectList.OpenProjectButton(at: project.url, label: Label.open)
						.disabled(!hasInstallationVersion)

					openWithMenu
				}

				Section {
					Button.info {
						Event.displayInfoSheet(project.url)
					}

					Toggle(isOn: $project.pinned, label: Label.pin)

					Button.showInFinder(destination: project.url)
				}
			}
			.disabled(!project.url.exists)

			Section {
				Button(
					role: .destructive,
					action: { Event.removeProject(project.url) },
					label: Label.remove
				)
				.keyboardShortcut(.delete)
			}
		}
	}
}

private extension ProjectList.Item.ContextMenu {
	var openWithMenu: some View {
		Menu(
			content: {
				let versions = installations.installations
					.compactMap(\.version)

				ForEach(installations.uniqueMajorVersions, id: \.self) { majorVersion in
					Section {
						let versionsInMajor = versions
							.filter { version in version.major == majorVersion }

						ForEach(versionsInMajor) { version in
							let disabled: Bool = version == project.editorVersion

							ProjectList.OpenProjectButton(
								at: project.url,
								with: version
							) {
								if disabled {
									Label(version.description, systemImage: Constant.Symbol.checkmark)
								} else {
									Text(version.description)
								}
							}
							.disabled(disabled)
						}
					}
				}
			},
			label: Label.openWith
		)
	}
}
