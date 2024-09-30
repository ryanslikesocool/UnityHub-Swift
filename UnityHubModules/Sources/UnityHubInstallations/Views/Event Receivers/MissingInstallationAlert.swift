import SwiftUI
import UnityHubCommon

struct MissingInstallationAlert: View {
	@EnvironmentObject private var model: InstallationsModel

	var body: some View {
		let isPresentingAlert = Binding(notNil: $model.state.missingInstallationURL)

		EmptyView()
			.confirmationDialog(
				makeTitle(),
				isPresented: isPresentingAlert,
				actions: makeActions,
				message: makeMessage
			)
			.dialogSeverity(.critical)
	}
}

// MARK: - Supporting Views

private extension MissingInstallationAlert {
	func makeTitle() -> Text {
		Text("Missing Installation")
	}

	@ViewBuilder
	func makeActions() -> some View {
		Button(role: .cancel, action: removeInstallation, label: Label.remove)
		Button(action: locateInstallation, label: Label.locate)
	}

	func makeMessage() -> some View {
		Text("The installation cannot be found.  It may have been moved or deleted.")
	}
}

// MARK: - Functions

private extension MissingInstallationAlert {
	func removeInstallation() {
		let url = consumeValue()
		model.state = .removeInstallation(url)
	}

	func locateInstallation() {
		let url = consumeValue()
		model.state = .locateInstallation(.replace(url))
	}

	func consumeValue() -> URL {
		guard let url = model.state.missingInstallationURL else {
			preconditionFailure(missingObject: URL.self)
		}
		model.state.missingInstallationURL = nil
		return url
	}
}

// MARK: - Convenience

extension View {
	func missingInstallationAlert() -> some View {
		background(content: MissingInstallationAlert.init)
	}
}