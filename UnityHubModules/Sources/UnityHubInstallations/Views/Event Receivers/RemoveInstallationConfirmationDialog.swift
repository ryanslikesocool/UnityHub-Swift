import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

private struct RemoveInstallationConfirmationDialog: View {
	@EnvironmentObject private var model: InstallationsModel

	@AppSetting(general: \.dialogSuppression) private var dialogSuppression
	@Cache(InstallationCache.self) private var installations

	@State private var isPresentingDialog: Bool = false

	public init() { }

	public var body: some View {
		EmptyView()
			.onChange(of: model.state.removeInstallationURL, onURLChanged)
			.confirmationDialog(
				makeTitle(),
				isPresented: $isPresentingDialog,
				actions: makeActions,
				message: makeMessage
			)
			.dialogSeverity(.critical)
			.dialogSuppressionToggle(isSuppressed: $dialogSuppression[.installationRemoval])
	}
}

// MARK: - Supporting Views

private extension RemoveInstallationConfirmationDialog {
	func makeTitle() -> Text {
		Text("Uninstall Editor")
	}

	func makeActions() -> some View {
		Button(role: .destructive, action: confirmRemoval, label: Label.remove)
	}

	func makeMessage() -> some View {
		Text("Do you want to uninstall this editor version?")
	}
}

// MARK: - Functions

private extension RemoveInstallationConfirmationDialog {
	func onURLChanged(_: URL?, url: URL?) {
		guard let url else {
			isPresentingDialog = false
			return
		}

		let fileManager: FileManager = .default

		if
			!fileManager.fileExists(at: url)
			|| dialogSuppression[.installationRemoval]
		{
			confirmRemoval()
		} else {
			isPresentingDialog = true
		}
	}

	func confirmRemoval() {
		let url = consumeValue()

		fatalError("\(Self.self).\(#function) is not implemented")

		installations.remove(at: url)
	}

	func consumeValue() -> URL {
		guard let url = model.state.removeInstallationURL else {
			preconditionFailure(missingObject: URL.self)
		}
		model.state.removeInstallationURL = nil
		return url
	}
}

// MARK: - Convenience

extension View {
	func removeInstallationConfirmationDialog() -> some View {
		background(content: RemoveInstallationConfirmationDialog.init)
	}
}
