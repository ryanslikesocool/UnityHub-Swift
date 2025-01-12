import SwiftUI

public protocol TaskButtonStyle: Sendable {
	associatedtype Body: View
	typealias Configuration = TaskButtonStyleConfiguration

	@ViewBuilder
	@MainActor
	func makeBody(configuration: Configuration) -> Self.Body
}
