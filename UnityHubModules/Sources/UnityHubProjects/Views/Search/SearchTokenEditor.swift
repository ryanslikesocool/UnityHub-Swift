import SwiftUI
import UnityHubProjectStorage
import UnityHubSettingsStorage

struct SearchTokenEditor: View {
	@Bindable private var projectListState: ProjectListState = .shared

	@Binding private var selection: ProjectSearchToken

	init(selection: Binding<ProjectSearchToken>) {
		_selection = selection
	}

	var body: some View {
		switch selection {
			case let .isPinned(value): isPinnedEditor(value: value)
			case let .editorVersion(value): editorVersionEditor(value: value)
		}
	}
}

// MARK: - Supporting Views

private extension SearchTokenEditor {
	private func isPinnedEditor(value: Bool) -> some View {
		let binding = Binding<Bool>(
			get: { value },
			set: { selection = .isPinned($0) }
		)

		return Picker("Pinned", selection: binding) {
			Text("Is").tag(true)
			Text("Is Not").tag(false)
		}
	}

	private func editorVersionEditor(value: UnityEditorVersion) -> some View {
		let binding = Binding<UnityEditorVersion>(
			get: { value },
			set: { selection = .editorVersion($0) }
		)
		let projectEditorVersions = projectListState.projectEditorVersions

		// NOTE: `Section` and `Divider` don't work in token pickers
		// FB13914296
		return Picker("Editor Version", selection: binding) {
			if projectEditorVersions.count > 1 {
				Text("Any").tag(UnityEditorVersion.search_any)
			}

			// TODO: only show if projects missing installs
			Text("Missing").tag(UnityEditorVersion.search_missing)

			Divider()

//			Section {
			ForEach(projectListState.projectEditorVersions) { version in
				Text(version.description).tag(version)
			}
//			}
		}
	}
}
