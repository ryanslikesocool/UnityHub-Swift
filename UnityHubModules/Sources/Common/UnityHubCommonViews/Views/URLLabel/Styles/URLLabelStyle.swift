import SwiftUI

public protocol URLLabelStyle: Sendable {
	associatedtype Body: View
	typealias Configuration = URLLabelStyleConfiguration

	@ViewBuilder
	@MainActor
	func makeBody(configuration: Configuration) -> Self.Body
}
