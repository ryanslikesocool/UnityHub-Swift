import SwiftUI
import UnityHubCommon
import UnityHubCommonViews

struct CreateProjectReceiver: View {
	@State private var isPresentingSheet: Bool = false

	var body: some View {
		EmptyView()
			.onReceive(Event.Project.create, perform: receiveEvent)
			.alert(
				"Not Implemented",
				isPresented: $isPresentingSheet,
				actions: { },
				message: {
					Text("Creating projects is not currently suppported.")
				}
			)
//			.sheet(isPresented: $isPresentingSheet, content: EmptyView.init)
	}
}

// MARK: - Functions

private extension CreateProjectReceiver {
	func receiveEvent() {
		isPresentingSheet = true
	}
}
