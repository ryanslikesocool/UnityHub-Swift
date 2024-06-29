import SwiftUI
import UnityHubStorage

protocol SettingsCategoryView: View {
	associatedtype Content: View
	associatedtype Label: View

	static var category: SettingsCategory { get }

	@ViewBuilder func makeContent() -> Content

	@ViewBuilder func makeLabel() -> Label
}

// MARK: - Default Implementation

extension SettingsCategoryView {
	var body: some View {
		Form(content: makeContent)
			.scrollDisabled(true)
			.tabItem(makeLabel)
			.tag(Self.category)
	}
}
