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
			let exists: Bool = installation.url.exists

			Group {
				Section {
					Button.info {
						print("\(Self.self).\(#function) is not implemented")
					}

					Button.showInFinder(destination: installation.url)
				}
				.disabled(!exists)

				Section {
					if let version = installation.version {
						Link(destination: version.manualURL, label: Label.manual)
						Link(destination: version.scriptReferenceURL, label: Label.scriptReference)
					}

					let bugReporterURL = installation.bugReporterURL
					Button(
						action: { NSWorkspace.shared.open(bugReporterURL) },
						label: Label.reportBug
					)
					.disabled(!bugReporterURL.exists)
				}

				Section {
					Button(
						role: .destructive,
						action: { Event.removeInstallation(installation.url) },
						label: exists ? Label.uninstall : Label.remove
					)
					.keyboardShortcut(.delete)
				}
			}
			.labelStyle(.titleAndIcon)
		}
	}
}
