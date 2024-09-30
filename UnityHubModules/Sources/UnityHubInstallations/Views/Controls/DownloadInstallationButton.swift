import SwiftUI
import UnityHubCommon

struct DownloadInstallationButton: View {
	@EnvironmentObject private var model: InstallationsModel

	public init() { }

	public var body: some View {
		Button(
			action: buttonAction,
			label: Label.download
		)
		.keyboardShortcut(Constant.Hotkey.new)
	}
}

// MARK: - Functions

private extension DownloadInstallationButton {
	func buttonAction() {
		model.state = .downloadInstallation
	}
}