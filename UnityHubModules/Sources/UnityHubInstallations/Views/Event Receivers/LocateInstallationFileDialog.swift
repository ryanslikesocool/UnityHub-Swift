import OSLog
import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

struct LocateInstallationFileDialog: View {
	@EnvironmentObject private var model: InstallationsModel

	@CacheFile(InstallationCache.self) private var installations

	public init() { }

	public var body: some View {
		let isPresentingFileDialog = Binding(notNil: $model.state.locateInstallationCompletion)

		EmptyView()
			.fileImporter(
				isPresented: isPresentingFileDialog,
				allowedContentTypes: [.application],
				onCompletion: onFileImporterComplete
			)
			.fileDialogDefaultDirectory(URL.applicationDirectory)
//			.fileDialogMessage(makeMessage())
			.fileDialogConfirmationLabel(makeConfirmationLabel())
	}
}

// MARK: - Supporting Views

private extension LocateInstallationFileDialog {
//	func makeMessage() -> Text {
	// depends on completion
//		Text("Locate the missing Unity installation")
//	}

	func makeConfirmationLabel() -> Text {
		Text("Select")
	}
}

// MARK: - Functions

private extension LocateInstallationFileDialog {
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
			model.state = .invalidInstallation(url)
		} catch InstallationError.alreadyExists {
			// TODO: automatically add installation to search field
		} catch {
			preconditionFailure(unexpectedError: error)
		}
	}

	func consumeValue() -> LocateEventCompletion {
		guard let completion = model.state.locateInstallationCompletion else {
			preconditionFailure(missingObject: LocateEventCompletion.self)
		}
		model.state.locateInstallationCompletion = nil
		return completion
	}
}

// MARK: - Convenience

extension View {
	func locateInstallationFileDialog() -> some View {
		background(content: LocateInstallationFileDialog.init)
	}
}
