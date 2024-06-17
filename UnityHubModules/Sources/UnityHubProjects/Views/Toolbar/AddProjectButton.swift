import OSLog
import SwiftUI
import UnityHubCommon
import UnityHubSettingsStorage

struct AddProjectButton: View {
	@Environment(\.addProject) private var addProject
	@State private var isPresentingFileImporter: Bool = false

	var body: some View {
		Menu(
			content: {
				addProjectButton
				openProjectButton
			},
			label: addProjectLabel,
			primaryAction: addProjectAction
		)
		.keyboardShortcut(Self.addKeyboardShortcut)
		.fileImporter(
			isPresented: $isPresentingFileImporter,
			allowedContentTypes: [.folder],
			onCompletion: onCompleteImport
		)
	}
}

// MARK: - Menu Items

private extension AddProjectButton {
	var addProjectButton: some View {
		Button(action: addProjectAction, label: addProjectLabel)
			.keyboardShortcut(Self.addKeyboardShortcut)
	}

	var openProjectButton: some View {
		Button("Open Project", systemImage: "folder") { }
			.keyboardShortcut(Self.openKeyboardShortcut)
			.disabled(true)
	}

	func addProjectLabel() -> some View {
		Label("Add Project", systemImage: "folder.badge.plus")
	}
}

// MARK: - Functions

private extension AddProjectButton {
	func addProjectAction() {
		isPresentingFileImporter = true
	}

	func onCompleteImport(result: Result<URL, Error>) {
		switch result {
			case let .failure(error): Logger.module.error("""
				Failed to select file:
				\(error.localizedDescription)
				""")
			case let .success(url):
				DispatchQueue.main.async {
					processURL(url)
				}
		}
	}

	func processURL(_ url: URL) {
		do {
			try addProject(at: url)
			// might want to put project in search field
		} catch let AddProjectActionError.missingRequiredObject(objectType) {
			preconditionFailure(missingObject: objectType)
		} catch AddProjectActionError.projectAlreadyExists {
			// TODO: jump to and highlight existing project
			// or just put project in search field
			// might want to show toast
		} catch AddProjectActionError.invalidUnityProject {
			// TODO: display issue
		} catch {
			Logger.module.error("""
			Failed to add project at \(url.path(percentEncoded: false)):
			\(error.localizedDescription)
			""")
		}
	}
}

// MARK: - Constants

private extension AddProjectButton {
	static let addKeyboardShortcut: KeyboardShortcut = KeyboardShortcut("o", modifiers: [.command])
	static let openKeyboardShortcut: KeyboardShortcut = KeyboardShortcut("o", modifiers: [.command, .shift])
}
