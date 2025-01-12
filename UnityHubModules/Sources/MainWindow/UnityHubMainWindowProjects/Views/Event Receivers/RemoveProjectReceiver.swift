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
				makeTitle(),
				isPresented: $isPresentingDialog,
				actions: makeActions,
				message: makeMessage
			)
			.dialogSuppressionToggle(isSuppressed: $dialogSuppression[.projectRemoval])
	}
}

// MARK: - Supporting Views

private extension RemoveProjectReceiver {
	func makeTitle() -> Text {
		Text(.removeProjectConfirmation.title)
	}

	@ViewBuilder
	func makeActions() -> some View {
		Button(
			role: .destructive,
			action: confirmRemoval,
			label: Label.remove
		)
	}

	func makeMessage() -> Text {
		Text(.removeProjectConfirmation.message)
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
