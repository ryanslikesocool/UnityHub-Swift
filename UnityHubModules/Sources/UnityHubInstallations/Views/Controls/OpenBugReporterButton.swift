import SwiftUI
import UnityHubCommon
import UnityHubStorageInstallations

struct OpenBugReporterButton: View {
	@Environment(\.openURL) private var openURL

	private let url: URL

	public init(installation: borrowing InstallationMetadata) {
		url = Utility.Application.Unity.getBugReporterURL(for: installation.url)
	}

	public var body: some View {
		Button(
			action: buttonAction,
			label: Label.reportBug
		)
		.disabled(isDisabled)
	}
}

// MARK: - Functions

private extension OpenBugReporterButton {
	var isDisabled: Bool {
		!FileManager.default.fileExists(at: url)
	}

	func buttonAction() {
		openURL(url)
	}
}
