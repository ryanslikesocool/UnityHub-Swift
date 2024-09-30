import SwiftUI
import UnityHubCommon

private struct DownloadInstallationSheet: View {
	@EnvironmentObject private var model: InstallationsModel

	public init() { }

	public var body: some View {
		let isPresentingSheet = Binding(
			$model.state,
			equals: .downloadInstallation,
			fallback: .default
		)

		EmptyView()
//			.alert(
//				"Not Implemented",
//				isPresented: $isPresentingSheet,
//				actions: { },
//				message: {
//					Text("Downloading installations is not currently suppported.")
//				}
//			)
			.sheet(
				isPresented: isPresentingSheet,
				content: DownloadSheet.init
			)
	}
}

// MARK: - Convenience

extension View {
	func downloadInstallationSheet() -> some View {
		background(content: DownloadInstallationSheet.init)
	}
}
