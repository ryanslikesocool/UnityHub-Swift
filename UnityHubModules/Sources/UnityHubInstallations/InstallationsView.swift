import SwiftUI

public struct InstallationsView: View {
	public init() { }

	public var body: some View {
		InstallationList()
			.toolbar {
				ToolbarItemGroup(placement: .confirmationAction) {
					AddInstallationList()
					SortMenu()
					InfoVisibilityMenu()
				}
			}

			/// cannot combine event receivers into a single `.background`
			/// for some reason, `EmptyView` works if done this way
			.background(content: LocateInstallationReceiver.init)
			.background(content: RemoveInstallationReceiver.init)
			.background(content: MissingInstallationAtURLReceiver.init)
			.background(content: DownloadInstallationReceiver.init)
	}
}
