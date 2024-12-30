import SwiftUI

protocol SidebarStyle: Sendable {
	associatedtype Body: View
	typealias Configuration = SidebarStyleConfiguration

	@ViewBuilder
	@MainActor
	func makeBody(configuration: Configuration) -> Self.Body
}
