import SwiftUI
import UnityHubStorage

public struct InstallationsView: View {
	@Bindable private var appSettings: AppSettings = .shared

	public init() { }

	public var body: some View {
		InstallationList()
			.toolbar {
				ToolbarItemGroup(placement: .confirmationAction) {
					AddInstallationList()
					SortMenu(order: $appSettings.installations.sortOrder)
					InfoVisibilityMenu(selection: $appSettings.installations.infoVisibility)
				}
			}

			/// cannot combine event receivers into a single `.background`
			/// for some reason, `EmptyView` works if done this way
			.background(content: LocateInstallationReceiver.init)
			.background(content: RemoveInstallationReceiver.init)
			.background(content: MissingInstallationReceiver.init)
	}
}
