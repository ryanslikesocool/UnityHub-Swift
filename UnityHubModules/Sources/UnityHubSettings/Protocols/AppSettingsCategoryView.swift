import SwiftUI
import UnityHubSettingsStorage

protocol AppSettingsCategoryView: View {
	associatedtype Content: View
	associatedtype Label: View
	associatedtype Model: AppSettingsCategoryStorage

	var model: Model { get set }

	@ViewBuilder var content: Content { get }

	@ViewBuilder var label: Label { get }
}

// MARK: - Default Implementation

extension AppSettingsCategoryView {
	var body: some View {
		Form {
			content
		}
		.onChange(of: model) { AppSettings.shared.save() }
		.tabItem { label }
		.tag(Model.category)
	}
}

extension AppSettingsCategoryView where Label == SwiftUI.Label<Text, Image> {
	var label: Label {
		SwiftUI.Label(Model.category.description, systemImage: Model.category.systemImageName)
	}
}
