import SwiftUI
import UnityHubCommonViews
import UnityHubStorage

public struct InstallationsView: View {
	@AppSetting(installation: \.sortOrder) private var sortOrder
	@AppSetting(installation: \.infoVisibility) private var infoVisibility

	public init() { }

	public var body: some View {
		InstallationList()
			.toolbar {
				ToolbarItemGroup(placement: .confirmationAction) {
					AddInstallationList()
					SortMenu(order: $sortOrder)
					InfoVisibilityMenu(selection: $infoVisibility)
				}
			}

			/// cannot combine event receivers into a single `.background`
			/// for some reason, `EmptyView` works if done this way
			.background(content: LocateInstallationReceiver.init)
			.background(content: RemoveInstallationReceiver.init)
			.background(content: MissingInstallationReceiver.init)
	}
}
