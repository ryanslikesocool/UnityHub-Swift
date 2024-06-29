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
			let fileManager: FileManager = .default
			let exists: Bool = fileManager.fileExists(at: installation.url)

			Section {
				Button.info {
					print("\(Self.self).\(#function) is not implemented")
				}

				Button.showInFinder(destination: installation.url)
			}
			.disabled(!exists)

			Section {
				if let version = (try? installation.version) {
					RealLink(destination: Utility.Version.getManualURL(version), label: Label.manual)
					RealLink(destination: Utility.Version.getScriptReferenceURL(version), label: Label.scriptReference)
				}

				let bugReporterURL = Utility.Application.Unity.getBugReporterURL(for: installation.url)
				Button(
					action: { NSWorkspace.shared.open(bugReporterURL) },
					label: Label.reportBug
				)
				.disabled(!fileManager.fileExists(at: bugReporterURL))
			}

			Section {
				Button(
					role: .destructive,
					action: { Event.Installation.remove(installation.url) },
					label: exists ? Label.uninstall : Label.remove
				)
				.keyboardShortcut(.delete)
			}
		}
	}
}
