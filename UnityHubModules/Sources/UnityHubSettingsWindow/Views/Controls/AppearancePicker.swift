import SwiftUI
import UnityHubCommonViews
import UnityHubStorageSettings

struct AppearancePicker: View {
	public typealias SelectionValue = Appearance

	@AppSetting(general: \.appearance) private var selection

	public init() { }

	public var body: some View {
		Picker(
			String(localized: .appearancePicker.label),
			selection: $selection
		) {
			makeItem(.system)

			Section {
				makeItem(.light)
				makeItem(.dark)
			}
		}
		.onChange(of: selection, selection.apply)
	}
}

// MARK: - Supporting Views

private extension AppearancePicker {
	func makeItem(_ value: SelectionValue) -> some View {
		Text(value.localizedStringResource)
			.tag(value)
	}
}