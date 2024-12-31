import SwiftUI
import UnityHubStorageSettings

struct BackgroundModePicker: View {
	public typealias SelectionValue = BackgroundMode

	@Binding private var selection: SelectionValue

	public init(selection: Binding<SelectionValue>) {
		_selection = selection
	}

	public var body: some View {
		Picker(selection: $selection) {
			makeItem(.none)

			Section {
				makeItem(.hide)
				makeItem(.quit)
			}
			.selectionDisabled()
		} label: {
			Text(.backgroundModePicker.label)
			Text(.backgroundModePicker.description)
		}
	}
}

// MARK: - Supporting Views

private extension BackgroundModePicker {
	func makeItem(_ value: SelectionValue) -> some View {
		Text(value.localizedStringResource)
			.tag(value)
	}
}