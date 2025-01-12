import SwiftUI
import UnityHubCommon

public struct SortOrderPicker<Label>: View where
	Label: View
{
	public typealias SelectionValue = SortOrder

	@Binding private var selection: SelectionValue
	private let label: Label

	/// - Parameters:
	///   - selection:
	///   - label:
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
				makeItem(.reverse)
				makeItem(.forward)
			}
		) {
			label
		}
	}
}

// MARK: - Supporting Views

private extension SortOrderPicker {
	func makeItem(
		_ value: SelectionValue
	) -> some View {
		SwiftUI.Label(
			String(localized: value.localizedStringResource),
			systemImage: value.systemSymbolName
		)
		.tag(value)
	}
}

// MARK: - Convenience

public extension SortOrderPicker
	where Label == Text
{
	/// - Parameters:
	///   - selection:
	init(selection: Binding<SelectionValue>) {
		self.init(selection: selection, label: { Text(.sortOrderPicker.title_short) })
	}

	/// - Parameters:
	///   - title:
	///   - selection:
	init<S>(
		_ title: S,
		selection: Binding<SelectionValue>
	) where
		S: StringProtocol
	{
		self.init(selection: selection, label: { Text(title) })
	}

	/// - Parameters:
	///   - titleKey:
	///   - selection:
	init(
		_ titleKey: LocalizedStringKey,
		selection: Binding<SelectionValue>
	) {
		self.init(selection: selection, label: { Text(titleKey) })
	}
}
