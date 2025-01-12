import SwiftUI

public struct TaskButton<Label>: View where
	Label: View
{
	@Environment(\.taskButtonStyle) private var style

	@State private var task: Task<Void, Never>? = nil
	private let role: ButtonRole?
	private let action: () async -> Void
	private let label: Label

	public init(
		role: ButtonRole? = nil,
		action: @escaping () async -> Void,
		@ViewBuilder label: () -> Label
	) {
		self.role = role
		self.action = action
		self.label = label()
	}

	public var body: some View {
		style.makeBody(
			configuration: TaskButtonStyleConfiguration(
				isExecuting: task != nil,
				label: label,
				action: buttonAction,
				role: role
			)
		)
	}
}

// MARK: - Functions

private extension TaskButton {
	func buttonAction() {
		task = Task {
			await action()

			await MainActor.run {
				self.task = nil
			}
		}
	}
}

// MARK: - Convenience

public extension TaskButton where
	Label == Text
{
	init<S>(
		_ title: S,
		role: ButtonRole? = nil,
		action: @escaping () async -> Void
	) where
		S: StringProtocol
	{
		self.init(role: role, action: action, label: { Text(title) })
	}

	init(
		_ titleKey: LocalizedStringKey,
		role: ButtonRole? = nil,
		action: @escaping () async -> Void
	) {
		self.init(role: role, action: action, label: { Text(titleKey) })
	}
}

public extension TaskButton where
	Label == SwiftUI.Label<Text, Image>
{
	init<S>(
		_ title: S,
		systemImage name: String,
		role: ButtonRole? = nil,
		action: @escaping () async -> Void
	) where
		S: StringProtocol
	{
		self.init(role: role, action: action, label: { Label(title, systemImage: name) })
	}

	init(
		_ titleKey: LocalizedStringKey,
		systemImage name: String,
		role: ButtonRole? = nil,
		action: @escaping () async -> Void
	) {
		self.init(role: role, action: action, label: { Label(titleKey, systemImage: name) })
	}

	init<S>(
		_ title: S,
		image: ImageResource,
		role: ButtonRole? = nil,
		action: @escaping () async -> Void
	) where
		S: StringProtocol
	{
		self.init(role: role, action: action, label: { Label(title, image: image) })
	}

	init(
		_ titleKey: LocalizedStringKey,
		image: ImageResource,
		role: ButtonRole? = nil,
		action: @escaping () async -> Void
	) {
		self.init(role: role, action: action, label: { Label(titleKey, image: image) })
	}
}
