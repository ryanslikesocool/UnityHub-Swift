import SwiftUI
import UnityHubStorageInstallations

struct RemoveInstallationButton: View {
	@EnvironmentObject private var model: InstallationsModel

	private let url: URL

	public init(installation: borrowing InstallationMetadata) {
		url = installation.url
	}

	public var body: some View {
		Button(
			role: .destructive,
			action: buttonAction,
			label: makeLabel
		)
		.keyboardShortcut(.delete)
	}
}

// MARK: - Supporting Views

private extension RemoveInstallationButton {
	func makeLabel() -> some View {
		if installationExists {
			Label.uninstall()
		} else {
			Label.remove()
		}
	}
}

// MARK: - Functions

private extension RemoveInstallationButton {
	var installationExists: Bool {
		FileManager.default.fileExists(at: url)
	}

	func buttonAction() {
		model.state = .removeInstallation(url)
	}
}
