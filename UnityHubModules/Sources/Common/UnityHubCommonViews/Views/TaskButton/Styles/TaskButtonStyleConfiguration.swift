import SwiftUI

public struct TaskButtonStyleConfiguration {
	public let isExecuting: Bool
	public let label: Label
	public let action: () -> Void
	public let role: ButtonRole?

	@MainActor
	init(
		isExecuting: Bool,
		label: some View,
		action: @escaping () -> Void,
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
