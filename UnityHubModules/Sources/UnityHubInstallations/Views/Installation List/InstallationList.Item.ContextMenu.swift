import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

extension InstallationList.Item {
	struct ContextMenu: View {
		private let installation: InstallationMetadata

		init(_ installation: InstallationMetadata) {
			self.installation = installation
		}

		var body: some View {
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
}
