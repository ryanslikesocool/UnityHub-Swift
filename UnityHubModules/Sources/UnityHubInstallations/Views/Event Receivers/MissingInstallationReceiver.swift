import SwiftUI
import UnityHubCommon

struct MissingInstallationReceiver: View {
	@State private var isPresentingDialog: Bool = false
	@State private var url: URL? = nil

	var body: some View {
		EmptyView()
			.onReceive(Event.missingInstallation) { url in
				self.url = url
				self.isPresentingDialog = true
			}
			.confirmationDialog(
				"Missing Project",
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

private extension MissingInstallationReceiver {
	func removeInstallation() {
		let url = receiveValue()
		Event.removeInstallation(url)
	}

	func locateInstallation() {
		let url = receiveValue()
		Event.locateInstallation(.replace(url))
	}

	func receiveValue() -> URL {
		guard let url else {
			preconditionFailure(missingObject: URL.self)
		}
		self.url = nil
		return url
	}
}
