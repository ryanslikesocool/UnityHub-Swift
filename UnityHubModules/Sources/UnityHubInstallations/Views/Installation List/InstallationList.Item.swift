import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

extension InstallationList {
	struct Item: View {
		@Binding private var installation: InstallationMetadata

		init(_ installation: Binding<InstallationMetadata>) {
			_installation = installation
		}

		var body: some View {
			ListItem {
				VStack(alignment: .leading, spacing: 1) {
					VersionLabel(installation.version)

					URLLabel(installation.url)
						.urlLabelStyle(.listItem)
				}

				Spacer()
			}
			.contextMenu(menuItems: contextMenuContent)
		}
	}
}

// MARK: - Supporting Views

private extension InstallationList.Item {
	func contextMenuContent() -> some View {
		Group {
			Section {
				Button.info {
					print("\(Self.self).\(#function) is not implemented")
				}

				Button.showInFinder(destination: installation.url)
			}

			if let version = installation.version {
				Section {
					Link(destination: version.manualURL, label: Label.manual)
					Link(destination: version.scriptReferenceURL, label: Label.scriptReference)
				}
			}

			Section {
				Button(role: .destructive, action: { Event.removeInstallation(installation.url) }, label: Label.uninstall)
					.keyboardShortcut(.delete)
			}
		}
		.labelStyle(.titleAndIcon)
	}
}
