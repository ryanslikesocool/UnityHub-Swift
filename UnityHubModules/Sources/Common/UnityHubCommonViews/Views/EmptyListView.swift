import SwiftUI

public struct EmptyListView<Label: View, Prompt: View>: View {
	public typealias LabelProvider = () -> Label
	public typealias PromptProvider = () -> Prompt

	private let label: LabelProvider
	private let prompt: PromptProvider

	public init(@ViewBuilder label: @escaping LabelProvider, @ViewBuilder prompt: @escaping PromptProvider) {
		self.label = label
		self.prompt = prompt
	}

	public var body: some View {
		VStack(spacing: 8) {
			label()
				.labelStyle(.large)

			Spacer()
				.frame(height: 16)

			prompt()
				.frame(maxWidth: .infinity)
				.foregroundStyle(.secondary)
				.controlSize(.large)
		}
	}
}
