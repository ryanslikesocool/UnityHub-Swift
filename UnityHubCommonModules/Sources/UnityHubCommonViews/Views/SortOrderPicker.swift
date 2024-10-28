import SwiftUI
import UnityHubCommon

public struct SortOrderPicker<Label: View>: View {
	public typealias LabelProvider = () -> Label

	@Binding private var selection: SortOrder
	private let label: LabelProvider

	public init(selection: Binding<SortOrder>, @ViewBuilder label: @escaping LabelProvider) {
		_selection = selection
		self.label = label
	}

	public var body: some View {
		Picker(
			selection: $selection,
			content: {
				SwiftUI.Label.ascending().tag(SortOrder.reverse)
				SwiftUI.Label.descending().tag(SortOrder.forward)
			},
			label: label
		)
	}
}

// MARK: - Convenience

public extension SortOrderPicker
	where Label == Text
{
	init(_ title: some StringProtocol, selection: Binding<SortOrder>) {
		self.init(selection: selection, label: { Text(title) })
	}

	init(_ titleKey: LocalizedStringKey, selection: Binding<SortOrder>) {
		self.init(selection: selection, label: { Text(titleKey) })
	}
}
