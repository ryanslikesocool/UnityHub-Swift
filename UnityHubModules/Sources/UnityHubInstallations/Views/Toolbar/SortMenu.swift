import SwiftUI
import UnityHubCommon
import UnityHubCommonViews

struct SortMenu: View {
	@AppSetting(installation: \.sortOrder) private var sortOrder

	public init() { }

	public var body: some View {
		Menu(
			content: makeContent,
			label: Label.sort,
			primaryAction: primaryAction
		)
		.pickerStyle(.inline)
	}
}

// MARK: - Supporting Views

private extension SortMenu {
	func makeContent() -> some View {
		SortOrderPicker("Order", selection: $sortOrder)
			.labelsHidden()
	}
}

// MARK: - Functions

private extension SortMenu {
	func primaryAction() {
		sortOrder = sortOrder.inverse
	}
}
