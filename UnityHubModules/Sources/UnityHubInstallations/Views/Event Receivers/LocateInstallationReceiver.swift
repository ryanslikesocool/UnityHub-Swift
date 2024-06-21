import OSLog
import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

struct LocateInstallationReceiver: View {
	@Cache(InstallationCache.self) private var installations

	@State private var isPresentingDialog: Bool = false
	@State private var completion: Completion? = nil

	var body: some View {
		EmptyView()
			.onReceive(Event.locateInstallation, perform: receiveEvent)
			.fileImporter(
				isPresented: $isPresentingDialog,
				allowedContentTypes: [.application],
				onCompletion: onFileImporterComplete
			)
			.fileDialogDefaultDirectory(URL.applicationDirectory)
			.fileDialogConfirmationLabel(Text("Select Installation"))
	}
}

// MARK: - Supporting Data

extension LocateInstallationReceiver {
	enum Completion {
		case add
		case replace(URL)
	}
}

// MARK: - Functions

private extension LocateInstallationReceiver {
	func receiveEvent(value: Completion) {
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
			Event.invalidEditor()
		} catch InstallationError.alreadyExists {
			// TODO: automatically add installation to search field
		} catch {
			preconditionFailure(unexpectedError: error)
		}
	}

	func consumeValue() -> Completion {
		guard let completion else {
			preconditionFailure(missingObject: Completion.self)
		}
		self.completion = nil
		return completion
	}
}
