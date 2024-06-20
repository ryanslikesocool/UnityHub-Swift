import SwiftUI
import UnityHubCommon

struct MissingProjectReceiver: View {
	@State private var isPresentingDialog: Bool = false
	@State private var url: URL? = nil

	var body: some View {
		EmptyView()
			.onReceive(Event.missingProject, perform: receiveEvent)
			.confirmationDialog(
				"Missing Project",
				isPresented: $isPresentingDialog,
				actions: {
					Button(role: .cancel, action: removeProject, label: Label.remove)
					Button(action: locateProject, label: Label.locate)
				},
				message: {
					Text("The project cannot be found.  It may have been moved or deleted.")
				}
			)
			.dialogSeverity(.critical)
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
		Event.removeProject(url)
	}

	func locateProject() {
		let url = consumeValue()
		Event.locateProject(.replace(url))
	}

	func consumeValue() -> URL {
		guard let url else {
			preconditionFailure(missingObject: URL.self)
		}
		self.url = nil
		return url
	}
}
