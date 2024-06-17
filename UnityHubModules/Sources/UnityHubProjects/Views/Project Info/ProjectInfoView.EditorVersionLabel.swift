import SwiftUI
import UnityHubStorage

extension ProjectInfoView {
	struct EditorVersionLabel: View {
		private let editorVersion: UnityEditorVersion?

		init(_ editorVersion: UnityEditorVersion?) {
			self.editorVersion = editorVersion
		}

		var body: some View {
			LabeledContent("Editor Version") {
				if let editorVersion {
					UnityEditorVersionView(editorVersion)
				} else {
					Text("Unknown")
						.foregroundStyle(.secondary)
				}
			}
		}
	}
}
