import SwiftUI
import UnityHubCommon

struct MissingProjectReceiver: View {
	@State private var isPresentingDialog: Bool = false
	@State private var url: URL? = nil

	var body: some View {
		EmptyView()
			.onReceive(Event.missingProject) { url in
				self.url = url
				self.isPresentingDialog = true
			}
			.confirmationDialog(
				"Missing Project",
				isPresented: $isPresentingDialog,
				actions: {
					Button(action: removeProject, label: Label.remove)
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
	func removeProject() {
		let url = receiveValue()
		Event.removeProject(url)
	}

	func locateProject() {
		let url = receiveValue()
		Event.locateProject(.replace(url))
	}

	func receiveValue() -> URL {
		guard let url else {
			preconditionFailure(missingObject: URL.self)
		}
		self.url = nil
		return url
	}
}
