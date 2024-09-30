import SwiftUI

public struct InstallationsView: View {
	@StateObject private var model: InstallationsModel = InstallationsModel()

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
			.locateInstallationFileDialog()
			.removeInstallationConfirmationDialog()
			.missingInstallationAlert()
			.downloadInstallationSheet()

			.environmentObject(model)
	}
}
