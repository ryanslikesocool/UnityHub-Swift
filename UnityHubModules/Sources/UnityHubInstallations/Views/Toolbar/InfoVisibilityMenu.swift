import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

struct InfoVisibilityMenu: View {
	@AppSetting(installation: \.infoVisibility) private var infoVisibility

	public init() { }

	public var body: some View {
		Menu(
			content: makeContent,
			label: Label.visibility
		)
	}
}

// MARK: - Supporting Views

private extension InfoVisibilityMenu {
	@ViewBuilder
	func makeContent() -> some View {
		Section {
			Toggle("Location", isOn: $infoVisibility[.location])
		}

		Section {
			Toggle("Badge", isOn: $infoVisibility[.badge])
		}
	}
}
