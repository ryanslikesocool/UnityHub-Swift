import SwiftUI

public protocol BadgeStyle: Sendable {
	associatedtype Body: View
	typealias Configuration = BadgeStyleConfiguration

	@ViewBuilder
	@MainActor
	func makeBody(configuration: Configuration) -> Self.Body
}
