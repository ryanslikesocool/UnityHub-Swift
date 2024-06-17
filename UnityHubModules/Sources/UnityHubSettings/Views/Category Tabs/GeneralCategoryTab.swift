import SwiftUI
import UnityHubSettingsStorage

struct GeneralCategoryTab: AppSettingsCategoryView {
	typealias Label = SwiftUI.Label<Text, Image>

	@Binding var model: AppSettings.General

	var content: some View {
		AppearancePicker($model.appearance)
	}
}
