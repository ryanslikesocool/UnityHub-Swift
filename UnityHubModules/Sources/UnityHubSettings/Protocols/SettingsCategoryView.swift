import SwiftUI
import UnityHubStorage

protocol SettingsCategoryView: View {
	associatedtype Content: View
	associatedtype Label: View

	static var category: SettingsCategory { get }

	@ViewBuilder func makeLabel() -> Label

	@ViewBuilder func makeContent() -> Content
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
