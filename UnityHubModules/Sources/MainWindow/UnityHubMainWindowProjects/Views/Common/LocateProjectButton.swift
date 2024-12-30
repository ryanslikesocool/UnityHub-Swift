import SwiftUI
import UnityHubCommon

struct LocateProjectButton: View {
	public init() { }

	public var body: some View {
		Button(action: buttonAction, label: Label.locate)
			.keyboardShortcut(.open)
	}
}

// MARK: - Functions

private extension LocateProjectButton {
	func buttonAction() {
		Event.Project.locate.send(.add)
	}
}
