import SwiftUI
import UnityHubCommon

public struct SortOrderPicker<Label>: View where
	Label: View
{
	public typealias SelectionValue = SortOrder

	@Binding private var selection: SelectionValue
	private let label: Label

	public init(
		selection: Binding<SelectionValue>,
		@ViewBuilder label: () -> Label
	) {
		_selection = selection
		self.label = label()
	}

	public var body: some View {
		Picker(
			selection: $selection,
			content: {
				makeItem(.reverse, relative: .ascending)
				makeItem(.forward, relative: .descending)

//				SwiftUI.Label(
//					String(localized: .sortOrderPicker.item.ascending),
//					systemImage: .arrow_up
//				)
//				.tag(SelectionValue.reverse)
//
//				SwiftUI.Label(
//					String(localized: .sortOrderPicker.item.descending),
//					systemImage: .arrow_down
//				)
//				.tag(SelectionValue.forward)
			}
		) {
			label
		}
	}
}

// MARK: - Supporting Views

private extension SortOrderPicker {
	func makeItem(
		_ value: SelectionValue,
		relative: SelectionValue.Relative
	) -> some View {
		SwiftUI.Label(
			String(localized: relative.localizedStringResource),
			systemImage: relative.systemSymbolName
		)
		.tag(value)
	}
}

// MARK: - Convenience

public extension SortOrderPicker
	where Label == Text
{
	init(selection: Binding<SelectionValue>) {
		self.init(selection: selection, label: { Text(.sortOrderPicker.title_short) })
	}

	init<S>(
		_ title: S,
		selection: Binding<SelectionValue>
	) where
		S: StringProtocol
	{
		self.init(selection: selection, label: { Text(title) })
	}

	init(
		_ titleKey: LocalizedStringKey,
		selection: Binding<SelectionValue>
	) {
		self.init(selection: selection, label: { Text(titleKey) })
	}
}
