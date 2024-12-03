import SwiftUI
import UnityHubCommon

struct CreateProjectButton: View {
	public init() { }

	public var body: some View {
		Button(action: buttonAction, label: Label.create)
			.keyboardShortcut(.new)
			.disabled(true)
	}
}

// MARK: - Functions

private extension CreateProjectButton {
	func buttonAction() {
		Event.Project.create.send()
	}
}
