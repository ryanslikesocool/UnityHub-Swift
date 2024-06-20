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
			.onReceive(Event.removeProject) { value in
				url = value
				if appSettings.general.dialogSuppression[.projectRemoval] {
					confirmRemoval()
				} else {
					isPresentingDialog = true
				}
			}
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
	func confirmRemoval() {
		guard let url else {
			preconditionFailure(missingObject: URL.self)
		}
		self.url = nil
		projectCache.removeProject(at: url)
	}
}
