import OSLog
import SwiftUI
import UnityHubCommon
import UnityHubStorage

struct AddProjectButton: View {
	@Environment(\.dismiss) private var dismiss

	@State private var isPresentingFileImporter: Bool = false
	@State private var isPresentingInvalidProjectWarning: Bool = false

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
		.alert("Missing Project", isPresented: $isPresentingInvalidProjectWarning, actions: { }, message: {
			Text("The directory does not contain a valid project, and cannot be added to the list.")
		})
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
					do {
						try ProjectCache.shared.addProject(at: url)
					} catch ProjectCache.AddProjectError.projectAlreadyExists {
						fatalError("\(Self.self).\(#function)@\(ProjectCache.AddProjectError.projectAlreadyExists) is not implemented")
					} catch ProjectCache.AddProjectError.invalidUnityProject {
						isPresentingInvalidProjectWarning = true
					} catch {
						preconditionFailure("""
						Caught unknown error \(type(of: error)):
						\(error.localizedDescription)
						""")
					}
				}
		}
	}
}

// MARK: - Constants

private extension AddProjectButton {
	static let addKeyboardShortcut: KeyboardShortcut = KeyboardShortcut("o", modifiers: [.command])
	static let openKeyboardShortcut: KeyboardShortcut = KeyboardShortcut("o", modifiers: [.command, .shift])
}
