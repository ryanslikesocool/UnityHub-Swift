import SwiftUI
import UnityHubCommon

struct LocateInstallationButton: View {
	@EnvironmentObject private var model: InstallationsModel

	public init() { }

	public var body: some View {
		Button(
			action: buttonAction,
			label: Label.locate
		)
		.keyboardShortcut(Constant.Hotkey.open)
	}
}

// MARK: - Functions

private extension LocateInstallationButton {
	func buttonAction() {
		model.state = .locateInstallation(.add)
	}
}