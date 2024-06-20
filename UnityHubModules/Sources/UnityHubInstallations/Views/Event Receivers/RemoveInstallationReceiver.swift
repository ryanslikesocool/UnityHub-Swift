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
			.onReceive(Event.removeInstallation) { url in
				self.url = url
				if appSettings.general.dialogSuppression[.installationRemoval] {
					confirmRemoval()
				} else {
					isPresentingDialog = true
				}
			}
			.confirmationDialog(
				"Uninstall Editor",
				isPresented: $isPresentingDialog,
				actions: {
					Button(role: .destructive, action: confirmRemoval, label: Label.uninstall)
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
	func confirmRemoval() {
		guard let url else {
			preconditionFailure(missingObject: URL.self)
		}
		self.url = nil

		print("\(Self.self).\(#function) is not implemented")
	}
}
