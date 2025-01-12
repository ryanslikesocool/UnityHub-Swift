import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorageInstallations
import UnityHubStorageSettings

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
			Toggle(
				.visibilityMenu.item.location,
				isOn: $infoVisibility[.location]
			)
		}

		Section {
			Toggle(
				.visibilityMenu.item.badge,
				isOn: $infoVisibility[.badge]
			)
		}
	}
}
