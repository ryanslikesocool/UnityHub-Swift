import OSLog
import SwiftUI
import UnityHubCommon
import UnityHubStorage

struct RemoveProjectReceiver: View {
	@Bindable private var appSettings: AppSettings = .shared
	@Bindable private var projectCache: ProjectCache = .shared

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
			.dialogSuppressionToggle(isSuppressed: $appSettings.general.dialogSuppression[.projectRemoval])
	}
}

// MARK: - Functions

private extension RemoveProjectReceiver {
	func receiveEvent(value: URL) {
		url = value
		if
			!value.exists
			|| appSettings.general.dialogSuppression[.projectRemoval]
		{
			confirmRemoval()
		} else {
			isPresentingDialog = true
		}
	}

	func confirmRemoval() {
		let url = consumeValue()
		projectCache.removeProject(at: url)
	}

	func consumeValue() -> URL {
		guard let url else {
			preconditionFailure(missingObject: URL.self)
		}
		self.url = nil
		return url
	}
}
