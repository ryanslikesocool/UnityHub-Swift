import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorageInstallations

extension InstallationList.Item {
	struct ContextMenu: View {
		private let installation: InstallationMetadata

		public init(_ installation: InstallationMetadata) {
			self.installation = installation
		}

		public var body: some View {
			let exists: Bool = FileManager.default.fileExists(at: installation.url)

			Section {
				InfoButton {
					fatalError("\(Self.self).\(#function) is not implemented")
				}
				.disabled(true)

				ShowInFinderButton(installation.url)
			}
			.disabled(!exists)

			Section {
				if let version = (try? installation.version) {
					RealLink(destination: Utility.Version.getManualURL(version), label: Label.manual)
					RealLink(destination: Utility.Version.getScriptReferenceURL(version), label: Label.scriptReference)
				}

				OpenBugReporterButton(installation: installation)
			}

			Section {
				RemoveInstallationButton(installation: installation)
			}
		}
	}
}
