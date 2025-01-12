import SwiftUI
import UnityHubCommonViews

struct CreditsListLink<Item>: View where
	Item: CreditItem
{
	/// - Parameters:
	///   - itemType:
	public init(ofType itemType: Item.Type) { }

	public var body: some View {
		Button(action: buttonAction) {
			Item.label
		}
		.buttonStyle(Self.buttonStyle)
		.controlSize(Self.controlSize)
		.disabled(true)
	}
}

// MARK: - Constants

private extension CreditsListLink {
	static var buttonStyle: some PrimitiveButtonStyle { .automatic.expandingLabel(.horizontal) }
	static var controlSize: ControlSize { .large }
}

// MARK: - Functions

private extension CreditsListLink {
	func buttonAction() {
		fatalError("\(Self.self).\(#function) is not implemented")
	}
}
