import SwiftUI
import UnityHubCommon
import UnityHubCommonViews

extension InstallationList.Item {
	struct IssueMenu: View {
		private let installationURL: URL
		private let flags: InstallationIssueFlags

		init(installationURL: URL, missingInstallation: Bool) {
			self.installationURL = installationURL

			var flags: InstallationIssueFlags = .none
			flags[.missingInstallation] = missingInstallation
			self.flags = flags
		}

		var body: some View {
			UnityHubCommonViews.IssueMenu(
				flags: flags,
				action: action,
				itemLabel: itemLabel
			)
		}
	}
}

// MARK: - Supporting View

private extension InstallationList.Item.IssueMenu {
	@ViewBuilder func itemLabel(flag: InstallationIssueFlags) -> some View {
		switch flag {
			case .missingInstallation: Text("Missing Installation")
			default: preconditionFailure("Unsupported \(InstallationIssueFlags.self) case \(flag).")
		}
	}
}

// MARK: - Actions

private extension InstallationList.Item.IssueMenu {
	func action(flag: InstallationIssueFlags) {
		switch flag {
			case .missingInstallation: Event.Installation.missingAtURL.send(installationURL)
			default: preconditionFailure("Unsupported \(InstallationIssueFlags.self) case \(flag).")
		}
	}
}
