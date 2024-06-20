import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

extension ProjectList.Item {
	struct EditorVersionLabel: View {
		private let editorVersion: UnityEditorVersion?

		init(_ editorVersion: UnityEditorVersion?) {
			self.editorVersion = editorVersion
		}

		var body: some View {
			if let editorVersion {
				UnityEditorVersionLabel(editorVersion)
					.contextMenu {
						Section {
							Link(destination: editorVersion.manualURL, label: Label.manual)
							Link(destination: editorVersion.scriptReferenceURL, label: Label.scriptReference)
						}

						Section {
							Button("Show in Installations", systemImage: Constant.Symbol.tray) {
								print("\(Self.self).\(#function) is not implemented")
							}
						}
					}
			}
		}
	}
}
