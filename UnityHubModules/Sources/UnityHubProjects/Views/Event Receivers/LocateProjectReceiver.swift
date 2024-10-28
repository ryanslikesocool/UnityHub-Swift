import OSLog
import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

struct LocateProjectReceiver: View {
	@CacheFile(ProjectCache.self) private var projects

	@State private var isPresentingDialog: Bool = false
	@State private var completion: LocateEventCompletion? = nil

	var body: some View {
		EmptyView()
			.onReceive(Event.Project.locate, perform: receiveEvent)
			.fileImporter(
				isPresented: $isPresentingDialog,
				allowedContentTypes: [.folder],
				onCompletion: onFileImporterComplete
			)
			.fileDialogDefaultDirectory(URL.documentsDirectory)
			.fileDialogConfirmationLabel(Text("Select"))
	}
}

// MARK: - Functions

private extension LocateProjectReceiver {
	func receiveEvent(value: LocateEventCompletion) {
		completion = value
		isPresentingDialog = true
	}

	func onFileImporterComplete(result: Result<URL, Error>) {
		switch result {
			case let .failure(error):
				Logger.module.error("""
				Failed to select project URL:
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
					try projects.add(at: url)
				case let .replace(oldURL):
					try projects.changeURL(from: oldURL, to: url)
			}
		} catch ProjectError.invalid {
			Event.Project.invalid.send()
		} catch ProjectError.alreadyExists {
			// TODO: automatically add project to search field
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
