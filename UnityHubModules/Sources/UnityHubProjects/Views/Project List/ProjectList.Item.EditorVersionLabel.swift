import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

extension ProjectList.Item {
	struct EditorVersionLabel: View {
		@Cache(InstallationCache.self) private var installations

		private let editorVersion: UnityEditorVersion?

		init(_ editorVersion: UnityEditorVersion?) {
			self.editorVersion = editorVersion
		}

		var body: some View {
			if let editorVersion {
				Menu(
					content: { menuContent(version: editorVersion) },
					label: { UnityEditorVersionLabel(editorVersion) }
				)
			}
		}
	}
}

// MARK: - Supporting Views

private extension ProjectList.Item.EditorVersionLabel {
	@ViewBuilder func menuContent(version: UnityEditorVersion) -> some View {
		Section {
			Link(destination: Utility.Version.getManualURL(version), label: Label.manual)
			Link(destination: Utility.Version.getScriptReferenceURL(version), label: Label.scriptReference)
		}

		if installations.contains(version) {
			Section {
				Button("Show in Installations", systemImage: Constant.Symbol.tray) {
					print("\(Self.self).\(#function) is not implemented")
				}
			}
		}
	}
}
