import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorageCommon
import UnityHubStorageInstallations
import UnityHubStorageProjects
import UnityHubStorageViews

struct SearchTokenEditor: View {
	@CacheFile(ProjectCache.self) private var projects

	@Binding var selection: SearchToken

	var body: some View {
		switch selection {
			case let .pinned(value): pinnedEditor(value: value)
			case let .editorVersion(value): editorVersionEditor(value: value)
		}
	}
}

// MARK: - Supporting Views

private extension SearchTokenEditor {
	func pinnedEditor(value: Bool) -> some View {
		let binding = Binding<Bool>(
			get: { value },
			set: { selection = .pinned($0) }
		)

		return Picker(
			selection: binding,
			content: {
				Text(.booleanSearchToken.item.is).tag(true)
				Text(.booleanSearchToken.item.isNot).tag(false)
			},
			label: Label.pinned
		)
	}

	func editorVersionEditor(value: UnityEditorVersion) -> some View {
		let binding = Binding<UnityEditorVersion>(
			get: { value },
			set: { selection = .editorVersion($0) }
		)
		let projectEditorVersions = projects.projectEditorVersions

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
			ForEach(projectEditorVersions) { version in
				Text(version.description).tag(version)
			}
//			}
		}
	}
}
