import SwiftUI
import UnityHubCommon
import UnityHubCommonViews

struct SortMenu: View {
	@AppSetting(installation: \.sortOrder) private var sortOrder

	var body: some View {
		Menu(
			content: {
				SortOrderPicker("Order", selection: $sortOrder)
					.labelsHidden()
			},
			label: Label.sort,
			primaryAction: { sortOrder = sortOrder.opposite }
		)
		.pickerStyle(.inline)
	}
}
