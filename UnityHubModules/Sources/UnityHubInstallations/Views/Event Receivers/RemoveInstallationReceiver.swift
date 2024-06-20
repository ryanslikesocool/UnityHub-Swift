import SwiftUI
import UnityHubCommon
import UnityHubStorage

struct RemoveInstallationReceiver: View {
	@Bindable private var appSettings: AppSettings = .shared
	@Bindable private var installationCache: InstallationCache = .shared

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
			.dialogSuppressionToggle(isSuppressed: $appSettings.general.dialogSuppression[.installationRemoval])
	}
}

// MARK: - Functions

private extension RemoveInstallationReceiver {
	func receiveEvent(value: URL) {
		url = value

		if
			!value.exists
			|| appSettings.general.dialogSuppression[.installationRemoval]
		{
			confirmRemoval()
		} else {
			isPresentingDialog = true
		}
	}

	func confirmRemoval() {
		let url = consumeValue()

		InstallationCache.shared.removeInstallation(at: url)
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
