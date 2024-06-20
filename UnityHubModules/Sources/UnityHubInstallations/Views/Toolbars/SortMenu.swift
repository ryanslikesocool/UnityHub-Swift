import SwiftUI
import UnityHubCommon
import UnityHubCommonViews

struct SortMenu: View {
	@Binding private var order: SortOrder

	init(order: Binding<SortOrder>) {
		_order = order
	}

	var body: some View {
		Menu(
			content: {
				SortOrderPicker("Order", selection: $order)
					.labelsHidden()
			},
			label: Label.sort
		)
		.pickerStyle(.inline)
	}
}
