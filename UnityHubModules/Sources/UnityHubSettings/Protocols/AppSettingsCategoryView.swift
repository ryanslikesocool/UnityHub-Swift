import SwiftUI
import UnityHubStorage

protocol AppSettingsCategoryView: View {
	associatedtype Content: View
	associatedtype Label: View
	associatedtype Model: AppSettingsCategoryStorage

	var model: Model { get set }

	@ViewBuilder func content() -> Content

	@ViewBuilder func label() -> Label
}

// MARK: - Default Implementation

extension AppSettingsCategoryView {
	var body: some View {
		Form(content: content)
			.onChange(of: model, AppSettings.shared.save)
			.tabItem(label)
			.tag(Model.category)
	}
}
