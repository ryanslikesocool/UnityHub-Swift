import SwiftUI
import UnityHubCommon

struct MissingProjectReceiver: View {
	@State private var isPresentingDialog: Bool = false
	@State private var url: URL? = nil

	var body: some View {
		EmptyView()
			.onReceive(Event.Project.missing, perform: receiveEvent)
			.confirmationDialog(
				makeTitle(),
				isPresented: $isPresentingDialog,
				actions: makeActions,
				message: makeMessage
			)
			.dialogSeverity(.critical)
	}
}

// MARK: - Supporting Views

private extension MissingProjectReceiver {
	func makeTitle() -> Text {
		Text(.missingProjectConfirmation.title)
	}

	@ViewBuilder
	func makeActions() -> some View {
		Button(
			role: .cancel,
			action: removeProject,
			label: Label.remove
		)

		Button(
			action: locateProject,
			label: Label.locate
		)
	}

	func makeMessage() -> Text {
		Text(.missingProjectConfirmation.message)
	}
}

// MARK: - Functions

private extension MissingProjectReceiver {
	func receiveEvent(value: URL) {
		url = value
		isPresentingDialog = true
	}

	func removeProject() {
		let url = consumeValue()
		Event.Project.remove.send(url)
	}

	func locateProject() {
		let url = consumeValue()
		Event.Project.locate.send(.replace(url))
	}

	func consumeValue() -> URL {
		guard let url else {
			preconditionFailure(missingObject: URL.self)
		}
		self.url = nil
		return url
	}
}
