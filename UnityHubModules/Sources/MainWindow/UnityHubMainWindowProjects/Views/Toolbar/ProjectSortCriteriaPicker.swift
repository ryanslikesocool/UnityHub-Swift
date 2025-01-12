import SwiftUI
import UnityHubStorageSettings

struct ProjectSortCriteriaPicker<Label>: View where
	Label: View
{
	public typealias SelectionValue = ProjectSortCriteria

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
		Picker(selection: $selection) {
			makeItem(.name)
			makeItem(.lastOpened)
			makeItem(.editorVersion)
		} label: {
			label
		}
	}
}

// MARK: - Supporting Views

private extension ProjectSortCriteriaPicker {
	func makeItem(
		_ value: SelectionValue
	) -> some View {
		Text(value.localizedStringResource)
			.tag(value)
	}
}

// MARK: - Convenience

extension ProjectSortCriteriaPicker where
	Label == Text
{
	init(
		selection: Binding<SelectionValue>
	) {
		self.init(selection: selection, label: { Text(.sortCriteriaPicker.title) })
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
