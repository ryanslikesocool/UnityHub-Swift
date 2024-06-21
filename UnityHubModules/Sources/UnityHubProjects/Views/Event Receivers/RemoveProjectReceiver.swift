import OSLog
import SwiftUI
import UnityHubCommon
import UnityHubStorage
import UnityHubCommonViews

struct RemoveProjectReceiver: View {
	@AppSetting(general: \.dialogSuppression) private var dialogSuppression
	@Cache(ProjectCache.self) private var projects

	@State private var isPresentingDialog: Bool = false
	@State private var url: URL? = nil

	var body: some View {
		EmptyView()
			.onReceive(Event.removeProject, perform: receiveEvent)
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
		if
			!value.exists
			|| dialogSuppression[.projectRemoval]
		{
			confirmRemoval()
		} else {
			isPresentingDialog = true
		}
	}

	func confirmRemoval() {
		let url = consumeValue()
		projects.removeProject(at: url)
	}

	func consumeValue() -> URL {
		guard let url else {
			preconditionFailure(missingObject: URL.self)
		}
		self.url = nil
		return url
	}
}
