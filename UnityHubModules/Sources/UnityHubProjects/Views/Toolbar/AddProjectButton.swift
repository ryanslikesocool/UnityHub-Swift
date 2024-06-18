import OSLog
import SwiftUI
import UnityHubCommon
import UnityHubStorage

struct AddProjectButton: View {
	@Environment(\.dismiss) private var dismiss

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
	}
}

// MARK: - Menu Items

private extension AddProjectButton {
	var addProjectButton: some View {
		Button(action: addProjectAction, label: addProjectLabel)
			.keyboardShortcut(Self.addKeyboardShortcut)
	}

	var openProjectButton: some View {
		Button("Open Project", systemImage: "folder") {
			print("\(Self.self).\(#function) is not implemented")
		}
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
		Event.importProject.send(.add)
	}
}

// MARK: - Constants

private extension AddProjectButton {
	static let addKeyboardShortcut: KeyboardShortcut = KeyboardShortcut("o", modifiers: [.command])
	static let openKeyboardShortcut: KeyboardShortcut = KeyboardShortcut("o", modifiers: [.command, .shift])
}
