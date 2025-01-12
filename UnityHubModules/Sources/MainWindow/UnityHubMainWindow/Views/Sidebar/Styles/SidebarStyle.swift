import SwiftUI

/// ## Topics
/// - ``SidebarStyleConfiguration``
///
/// ### Environment
/// - ``SwiftUICore/View/sidebarStyle(_:)``
/// - ``SwiftUICore/EnvironmentValues/sidebarStyle``
protocol SidebarStyle: Sendable {
	associatedtype Body: View
	typealias Configuration = SidebarStyleConfiguration

	@ViewBuilder
	@MainActor
	func makeBody(configuration: Configuration) -> Self.Body
}
