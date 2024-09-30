import SwiftUI
import UnityHubStorage

public struct TaskButtonStyleConfiguration {
	public typealias Action = () -> Void

	public let isExecuting: Bool
	public let label: Label
	public let action: Action
	public let role: ButtonRole?

	@MainActor
	init(
		isExecuting: Bool,
		label: some View,
		action: @escaping Action,
		role: ButtonRole?
	) {
		self.isExecuting = isExecuting
		self.label = Label(label)
		self.action = action
		self.role = role
	}
}

// MARK: - Supporting Data

public extension TaskButtonStyleConfiguration {
	/// The type-erased label of a ``TaskButton``.
	struct Label: View {
		fileprivate init(_ content: some View) {
			body = AnyView(content)
		}

		public var body: AnyView
	}
}
