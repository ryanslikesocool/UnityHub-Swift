import OSLog
import SwiftUI
import UnityHubCommon
import UnityHubStorage

struct InvalidProjectReceiver: View {
	@Bindable private var projectCache: ProjectCache = .shared

	@State private var isPresentingDialog: Bool = false

	var body: some View {
		EmptyView()
			.onReceive(Event.invalidProject, perform: receiveEvent)
			.alert(
				"Invalid Project",
				isPresented: $isPresentingDialog,
				actions: { },
				message: {
					Text("The directory does not contain a valid project.")
				}
			)
	}
}

// MARK: - Functions

private extension InvalidProjectReceiver {
	func receiveEvent() {
		isPresentingDialog = true
	}
}
