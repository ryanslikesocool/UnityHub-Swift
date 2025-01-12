import SwiftUI
import UnityHubCommon

public struct SortOrderPicker<Label>: View where
	Label: View
{
	@Binding private var selection: SortOrder
	private let label: Label

	public init(
		selection: Binding<SortOrder>,
		@ViewBuilder label: () -> Label
	) {
		_selection = selection
		self.label = label()
	}

	public var body: some View {
		Picker(
			selection: $selection,
			content: {
				SwiftUI.Label.ascending().tag(SortOrder.reverse)
				SwiftUI.Label.descending().tag(SortOrder.forward)
			}
		) {
			label
		}
	}
}

// MARK: - Convenience

public extension SortOrderPicker
	where Label == Text
{
	init<S>(
		_ title: S,
		selection: Binding<SortOrder>
	) where
		S: StringProtocol
	{
		self.init(selection: selection, label: { Text(title) })
	}

	init(
		_ titleKey: LocalizedStringKey,
		selection: Binding<SortOrder>
	) {
		self.init(selection: selection, label: { Text(titleKey) })
	}
}
