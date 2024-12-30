import OSLog
import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorageCommon
import UnityHubStorageProjects
import UnityHubStorageSettings

struct RemoveProjectReceiver: View {
	@AppSetting(general: \.dialogSuppression) private var dialogSuppression
	@CacheFile(ProjectCache.self) private var projects

	@State private var isPresentingDialog: Bool = false
	@State private var url: URL? = nil

	var body: some View {
		EmptyView()
			.onReceive(Event.Project.remove, perform: receiveEvent)
			.confirmationDialog(
				"Remove Project?",
				isPresented: $isPresentingDialog,
				actions: {
					Button(role: .destructive, action: confirmRemoval, label: Label.remove)
				}, message: {
					Text("The project files will remain on your disk.")
				}
			)
			.dialogSuppressionToggle(isSuppressed: $dialogSuppression[.projectRemoval])
	}
}

// MARK: - Functions

private extension RemoveProjectReceiver {
	func receiveEvent(value: URL) {
		url = value
		let fileManager: FileManager = .default

		if
			!fileManager.directoryExists(at: value)
			|| dialogSuppression[.projectRemoval]
		{
			confirmRemoval()
		} else {
			isPresentingDialog = true
		}
	}

	func confirmRemoval() {
		let url = consumeValue()
		projects.remove(at: url)
	}

	func consumeValue() -> URL {
		guard let url else {
			preconditionFailure(missingObject: URL.self)
		}
		self.url = nil
		return url
	}
}
