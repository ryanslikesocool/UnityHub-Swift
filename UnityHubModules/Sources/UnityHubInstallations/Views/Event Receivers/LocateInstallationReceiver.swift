import OSLog
import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

struct LocateInstallationReceiver: View {
	@Cache(InstallationCache.self) private var installations

	@State private var isPresentingDialog: Bool = false
	@State private var completion: LocateEventCompletion? = nil

	var body: some View {
		EmptyView()
			.onReceive(Event.Installation.locate, perform: receiveEvent)
			.fileImporter(
				isPresented: $isPresentingDialog,
				allowedContentTypes: [.application],
				onCompletion: onFileImporterComplete
			)
			.fileDialogDefaultDirectory(URL.applicationDirectory)
			.fileDialogConfirmationLabel(Text("Select Installation"))
	}
}

// MARK: - Functions

private extension LocateInstallationReceiver {
	func receiveEvent(value: LocateEventCompletion) {
		completion = value
		isPresentingDialog = true
	}

	func onFileImporterComplete(result: Result<URL, Error>) {
		switch result {
			case let .failure(error):
				Logger.module.error("""
				Failed to select editor URL:
				\(error.localizedDescription)
				""")
			case let .success(url): finalizeImport(at: url)
		}
	}

	func finalizeImport(at url: URL) {
		let completion = consumeValue()

		do {
			switch completion {
				case .add:
					try installations.add(at: url)
				case let .replace(oldURL):
					try installations.changeURL(from: oldURL, to: url)
			}
		} catch InstallationError.invalid {
			Event.Installation.invalid.send()
		} catch InstallationError.alreadyExists {
			// TODO: automatically add installation to search field
		} catch {
			preconditionFailure(unexpectedError: error)
		}
	}

	func consumeValue() -> LocateEventCompletion {
		guard let completion else {
			preconditionFailure(missingObject: LocateEventCompletion.self)
		}
		self.completion = nil
		return completion
	}
}
