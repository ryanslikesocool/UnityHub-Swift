import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

struct RemoveInstallationReceiver: View {
	@AppSetting(general: \.dialogSuppression) private var dialogSuppression
	@Cache(InstallationCache.self) private var installations

	@State private var isPresentingDialog: Bool = false
	@State private var url: URL? = nil

	var body: some View {
		EmptyView()
			.onReceive(Event.removeInstallation, perform: receiveEvent)
			.confirmationDialog(
				"Uninstall Editor",
				isPresented: $isPresentingDialog,
				actions: {
					Button(role: .destructive, action: confirmRemoval, label: Label.remove)
				},
				message: {
					Text("Do you want to uninstall this editor version?")
				}
			)
			.dialogSeverity(.critical)
			.dialogSuppressionToggle(isSuppressed: $dialogSuppression[.installationRemoval])
	}
}

// MARK: - Functions

private extension RemoveInstallationReceiver {
	func receiveEvent(value: URL) {
		url = value

		let fileManager: FileManager = .default

		if
			!fileManager.fileExists(at: value)
			|| dialogSuppression[.installationRemoval]
		{
			confirmRemoval()
		} else {
			isPresentingDialog = true
		}
	}

	func confirmRemoval() {
		let url = consumeValue()

		installations.remove(at: url)
		print("\(Self.self).\(#function) is not implemented")
	}

	func consumeValue() -> URL {
		guard let url else {
			preconditionFailure(missingObject: URL.self)
		}
		self.url = nil
		return url
	}
}
