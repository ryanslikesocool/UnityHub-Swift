import SwiftUI

public struct EmptyListView<Label, Prompt>: View where
	Label: View,
	Prompt: View
{
	private let label: Label
	private let prompt: Prompt

	public init(
		@ViewBuilder label: () -> Label,
		@ViewBuilder prompt: () -> Prompt
	) {
		self.label = label()
		self.prompt = prompt()
	}

	public var body: some View {
		VStack(spacing: Self.spacing) {
			label
				.labelStyle(.large)

			Spacer()
				.frame(height: Self.spacerHeight)

			prompt
				.frame(maxWidth: .infinity)
				.foregroundStyle(.secondary)
				.controlSize(.large)
		}
	}
}

// MARK: - Constants

private extension EmptyListView {
	static var spacing: CGFloat { 8 }
	static var spacerHeight: CGFloat { 16 }
}