import OSLog
import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorageProjects

struct InvalidProjectReceiver: View {
	@State private var isPresentingDialog: Bool = false

	var body: some View {
		EmptyView()
			.onReceive(Event.Project.invalid, perform: receiveEvent)
			.alert(
				makeTitle(),
				isPresented: $isPresentingDialog,
				actions: makeActions,
				message: makeMessage
			)
	}
}

// MARK: - Supporting Views

private extension InvalidProjectReceiver {
	func makeTitle() -> Text {
		Text(.invalidProjectAlert.title)
	}

	@ViewBuilder
	func makeActions() -> some View {
		
	}

	func makeMessage() -> Text {
		Text(.invalidProjectAlert.message)
	}
}

// MARK: - Functions

private extension InvalidProjectReceiver {
	func receiveEvent() {
		isPresentingDialog = true
	}
}
