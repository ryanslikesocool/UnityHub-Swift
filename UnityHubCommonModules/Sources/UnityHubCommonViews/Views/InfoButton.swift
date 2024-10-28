import SwiftUI

public struct InfoButton: View {
	private let action: () -> Void

	public init(action: @escaping () -> Void) {
		self.action = action
	}

	public var body: some View  {
		Button(action: action, label: Label.info)
			.keyboardShortcut(.info)
	}
}