import SwiftUI
import UnityHubCommonViews
import UnityHubStorageInstallations
import UnityHubStorageProjects
import UnityHubStorageViews

extension ProjectInfoSheet {
	struct EditorVersionLabel: View {
		private let editorVersion: UnityEditorVersion?

		init(_ editorVersion: UnityEditorVersion?) {
			self.editorVersion = editorVersion
		}

		var body: some View {
			LabeledContent("Editor Version", content: makeContent)
		}
	}
}

// MARK: - Supporting Views

private extension ProjectInfoSheet.EditorVersionLabel {
	@ViewBuilder
	func makeContent() -> some View {
		if let editorVersion {
			UnityEditorVersionLabel(editorVersion)
		} else {
			Text("Unknown")
				.foregroundStyle(.secondary)
		}
	}
}
