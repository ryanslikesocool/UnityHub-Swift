import SwiftUI

public protocol URLPickerStyle: Sendable {
	associatedtype Body: View
	typealias Configuration = URLPickerStyleConfiguration

	@ViewBuilder
	@MainActor
	func makeBody(configuration: Configuration) -> Self.Body
}
