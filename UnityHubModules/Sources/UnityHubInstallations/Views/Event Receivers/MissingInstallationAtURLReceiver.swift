import SwiftUI
import UnityHubCommon

struct MissingInstallationAtURLReceiver: View {
	@State private var isPresentingDialog: Bool = false
	@State private var url: URL? = nil

	var body: some View {
		EmptyView()
			.onReceive(Event.Installation.missingAtURL, perform: receiveEvent)
			.confirmationDialog(
				"Missing Installation",
				isPresented: $isPresentingDialog,
				actions: {
					Button(role: .cancel, action: removeInstallation, label: Label.remove)
					Button(action: locateInstallation, label: Label.locate)
				},
				message: {
					Text("The installation cannot be found.  It may have been moved or deleted.")
				}
			)
			.dialogSeverity(.critical)
	}
}

// MARK: - Functions

private extension MissingInstallationAtURLReceiver {
	func receiveEvent(value: URL) {
		url = value
		isPresentingDialog = true
	}

	func removeInstallation() {
		let url = consumeValue()
		Event.Installation.remove(url)
	}

	func locateInstallation() {
		let url = consumeValue()
		Event.Installation.locate(.replace(url))
	}

	func consumeValue() -> URL {
		guard let url else {
			preconditionFailure(missingObject: URL.self)
		}
		self.url = nil
		return url
	}
}
