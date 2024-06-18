import OSLog
import SwiftUI
import UnityHubCommon
import UnityHubStorage

struct RemoveProjectReceiver: View {
	@AppStorage("SupressProjectRemovalDialog") private var supressProjectRemovalDialog: Bool = false

	@Bindable private var projectCache: ProjectCache = .shared

	@State private var isPresentingDialog: Bool = false
	@State private var url: URL? = nil

	var body: some View {
		EmptyView()
			.onReceive(Event.removeProject) { value in
				url = value
				isPresentingDialog = true
			}
			.confirmationDialog(
				"Remove Project?",
				isPresented: $isPresentingDialog,
				actions: {
					Button("Remove", systemImage: "trash", role: .destructive, action: onConfirmRemoval)
				}, message: {
					Text("The project files will remain on your disk.")
				}
			)
			.dialogSuppressionToggle(isSuppressed: $supressProjectRemovalDialog)
	}
}

// MARK: - Functions

private extension RemoveProjectReceiver {
	func onConfirmRemoval() {
		projectCache.removeProject(at: receiveURL())
	}

	func receiveURL() -> URL {
		guard let url else {
			preconditionFailure(missingObject: URL.self)
		}
		self.url = nil
		return url
	}
}
