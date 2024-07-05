import SwiftUI
import UnityHubStorage

public struct TaskButtonStyleConfiguration: ViewStyleConfiguration {
	public typealias Action = () -> Void

	/// The type-erased label of a ``TaskButton``.
	public struct Label: View {
		init(content: some View) {
			body = AnyView(content)
		}

		public var body: AnyView
	}

	public let isExecuting: Bool
	public let label: Label
	public let action: Action
	public let role: ButtonRole?

	init(
		isExecuting: Bool,
		label: some View,
		action: @escaping Action,
		role: ButtonRole?
	) {
		self.isExecuting = isExecuting
		self.label = Label(content: label)
		self.action = action
		self.role = role
	}
}
