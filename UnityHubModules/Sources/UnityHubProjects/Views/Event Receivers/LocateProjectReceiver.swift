import OSLog
import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

struct LocateProjectReceiver: View {
	@Cache(ProjectCache.self) private var projects

	@State private var isPresentingDialog: Bool = false
	@State private var completion: Completion? = nil

	var body: some View {
		EmptyView()
			.onReceive(Event.locateProject, perform: receiveEvent)
			.fileImporter(
				isPresented: $isPresentingDialog,
				allowedContentTypes: [.folder],
				onCompletion: onFileImporterComplete
			)
			.fileDialogDefaultDirectory(URL.documentsDirectory)
			.fileDialogConfirmationLabel(Text("Select"))
	}
}

// MARK: - Supporting Data

extension LocateProjectReceiver {
	enum Completion {
		case add
		case replace(URL)

		static func replace(_ project: borrowing ProjectMetadata) -> Self { .replace(project.url) }
	}
}

// MARK: - Functions

private extension LocateProjectReceiver {
	func receiveEvent(value: Completion) {
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
					try projects.addProject(at: url)
				case let .replace(oldURL):
					try projects.changeProjectURL(from: oldURL, to: url)
			}
		} catch ProjectError.invalid {
			Event.invalidProject()
		} catch ProjectError.alreadyExists {
			// TODO: automatically add project to search field
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
