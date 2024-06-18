import OSLog
import SwiftUI
import UnityHubCommon
import UnityHubStorage

struct ImportProjectReceiver: View {
	@Bindable private var projectCache: ProjectCache = .shared

	@State private var isPresentingDialog: Bool = false
	@State private var completion: Completion? = nil

	var body: some View {
		EmptyView()
			.onReceive(Event.importProject) { value in
				completion = value
				isPresentingDialog = true
			}
			.fileImporter(
				isPresented: $isPresentingDialog,
				allowedContentTypes: [.folder],
				onCompletion: onCompleteFileImporter
			)
	}
}

// MARK: - Supporting Data

extension ImportProjectReceiver {
	enum Completion {
		case add
		case replace(URL)
		case temporary

		static func replace(_ project: borrowing ProjectMetadata) -> Self { .replace(project.url) }
	}
}

// MARK: - Functions

private extension ImportProjectReceiver {
	func onCompleteFileImporter(result: Result<URL, Error>) {
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
		do {
			switch receiveCompletion() {
				case .add:
					try projectCache.addProject(at: url)
				case let .replace(oldURL):
					try projectCache.changeProjectURL(from: oldURL, to: url)
				case .temporary:
					print("\(Self.self).\(#function):Completion.temporary is not implemented")
			}
		} catch ProjectCache.ProjectError.invalid {
			// TODO: reimplement invalid project warning
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

	func receiveCompletion() -> Completion {
		guard let completion else {
			preconditionFailure(missingObject: Completion.self)
		}
		self.completion = nil
		return completion
	}
}
