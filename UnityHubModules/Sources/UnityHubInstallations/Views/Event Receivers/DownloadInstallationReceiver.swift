import SwiftUI
import UnityHubCommon
import UnityHubCommonViews

struct DownloadInstallationReceiver: View {
	@State private var isPresentingSheet: Bool = false

	var body: some View {
		EmptyView()
			.onReceive(Event.downloadInstallation, perform: receiveEvent)
			.alert(
				"Not Implemented",
				isPresented: $isPresentingSheet,
				actions: { },
				message: {
					Text("Downloading installations is not currently suppported.")
				}
			)
//			.sheet(isPresented: $isPresentingSheet, content: EmptyView.init)
	}
}

// MARK: - Functions

private extension DownloadInstallationReceiver {
	func receiveEvent() {
		isPresentingSheet = true
	}
}
