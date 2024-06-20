import OSLog
import SwiftUI
import UnityHubCommon
import UnityHubStorage

struct LocateProjectReceiver: View {
	@Bindable private var projectCache: ProjectCache = .shared

	@State private var isPresentingDialog: Bool = false
	@State private var completion: Completion? = nil

	var body: some View {
		EmptyView()
			.onReceive(Event.locateProject) { value in
				completion = value
				isPresentingDialog = true
			}
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
		guard let completion else {
			preconditionFailure(missingObject: Completion.self)
		}
		self.completion = nil

		do {
			switch completion {
				case .add:
					try projectCache.addProject(at: url)
				case let .replace(oldURL):
					try projectCache.changeProjectURL(from: oldURL, to: url)
			}
		} catch ProjectCache.ProjectError.invalid {
			Event.invalidProject()
		} catch ProjectCache.ProjectError.alreadyExists {
			// TODO: automatically add project to search field
		} catch {
			preconditionFailure("""
			Caught an unexpected error:
			\(error.localizedDescription)
			""")
		}
	}
}
