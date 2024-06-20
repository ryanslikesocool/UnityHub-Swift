import OSLog
import SwiftUI
import UnityHubCommon
import UnityHubStorage

struct LocateInstallationReceiver: View {
	@Bindable private var installationCache: InstallationCache = .shared

	@State private var isPresentingDialog: Bool = false
	@State private var completion: Completion? = nil

	var body: some View {
		EmptyView()
			.onReceive(Event.locateInstallation) { completion in
				isPresentingDialog = true
				self.completion = completion
			}
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
		guard let completion else {
			preconditionFailure(missingObject: Completion.self)
		}
		self.completion = nil

		do {
			switch completion {
				case .add:
					try installationCache.addInstallation(at: url)
				case let .replace(oldURL):
					try installationCache.changeInstallationURL(from: oldURL, to: url)
			}
		} catch InstallationCache.InstallationError.invalid {
			Event.invalidEditor()
		} catch InstallationCache.InstallationError.alreadyExists {
			// TODO: automatically add installation to search field
		} catch {
			preconditionFailure("""
			Caught an unexpected error:
			\(error.localizedDescription)
			""")
		}
	}
}
