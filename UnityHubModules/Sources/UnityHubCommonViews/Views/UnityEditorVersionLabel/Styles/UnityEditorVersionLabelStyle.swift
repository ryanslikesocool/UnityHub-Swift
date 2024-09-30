import SwiftUI

public protocol UnityEditorVersionLabelStyle: Sendable {
	associatedtype Body: View
	typealias Configuration = UnityEditorVersionLabelStyleConfiguration

	@ViewBuilder
	@MainActor
	func makeBody(configuration: Configuration) -> Self.Body
}
