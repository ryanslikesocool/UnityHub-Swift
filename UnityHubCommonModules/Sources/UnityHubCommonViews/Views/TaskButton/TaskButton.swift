import SwiftUI

public struct TaskButton<Label: View>: View {
	public typealias LabelProvider = () -> Label
	public typealias Task = _Concurrency.Task<Void, Never>
	public typealias Action = () async -> Void

	@Environment(\.taskButtonStyle) private var style

	@State private var task: Task? = nil
	private let role: ButtonRole?
	private let action: Action
	private let label: LabelProvider

	public init(
		role: ButtonRole? = nil,
		action: @escaping Action,
		@ViewBuilder label: @escaping LabelProvider
	) {
		self.role = role
		self.action = action
		self.label = label
	}

	public var body: some View {
		style.makeBody(
			configuration: TaskButtonStyleConfiguration(
				isExecuting: task != nil,
				label: label(),
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

// MARK: - Init+

public extension TaskButton where Label == Text {
	init(_ title: some StringProtocol, role: ButtonRole? = nil, action: @escaping Action) {
		self.init(role: role, action: action, label: { Text(title) })
	}

	init(_ titleKey: LocalizedStringKey, role: ButtonRole? = nil, action: @escaping Action) {
		self.init(role: role, action: action, label: { Text(titleKey) })
	}
}

public extension TaskButton where Label == SwiftUI.Label<Text, Image> {
	init(_ title: some StringProtocol, systemImage name: String, role: ButtonRole? = nil, action: @escaping Action) {
		self.init(role: role, action: action, label: { Label(title, systemImage: name) })
	}

	init(_ titleKey: LocalizedStringKey, systemImage name: String, role: ButtonRole? = nil, action: @escaping Action) {
		self.init(role: role, action: action, label: { Label(titleKey, systemImage: name) })
	}

	init(_ title: some StringProtocol, image: ImageResource, role: ButtonRole? = nil, action: @escaping Action) {
		self.init(role: role, action: action, label: { Label(title, image: image) })
	}

	init(_ titleKey: LocalizedStringKey, image: ImageResource, role: ButtonRole? = nil, action: @escaping Action) {
		self.init(role: role, action: action, label: { Label(titleKey, image: image) })
	}
}
