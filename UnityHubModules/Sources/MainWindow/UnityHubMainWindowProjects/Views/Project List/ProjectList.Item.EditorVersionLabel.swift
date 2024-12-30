import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorageCommon
import UnityHubStorageInstallations
import UnityHubStorageProjects
import UnityHubStorageSettings
import UnityHubStorageViews

extension ProjectList.Item {
	struct EditorVersionLabel: View {
		@CacheFile(InstallationCache.self) private var installations
		@AppSetting(project: \.infoVisibility) private var infoVisibility

		private let editorVersion: UnityEditorVersion?

		init(_ editorVersion: UnityEditorVersion?) {
			self.editorVersion = editorVersion
		}

		var body: some View {
			if
				let editorVersion,
				infoVisibility.contains(.editorVersion)
			{
				Menu(
					content: { menuContent(version: editorVersion) },
					label: {
						UnityEditorVersionLabel(editorVersion)
							.unityEditorVersionLabelStyle(editorVersionLabelStyle)
					}
				)
			}
		}
	}
}

// MARK: - Supporting Views

private extension ProjectList.Item.EditorVersionLabel {
	@ViewBuilder
	func menuContent(version: UnityEditorVersion) -> some View {
		Section {
			RealLink(destination: Utility.Version.getManualURL(version), label: Label.manual)
			RealLink(destination: Utility.Version.getScriptReferenceURL(version), label: Label.scriptReference)
		}

		if installations.contains(version) {
			Section {
				Button("Show in Installations", systemImage: Symbol.tray) {
					print("\(Self.self).\(#function) is not implemented")
				}
			}
		}
	}

	var editorVersionLabelStyle: AnyUnityEditorVersionLabelStyle {
		if infoVisibility.contains(.editorVersionBadge) {
			AnyUnityEditorVersionLabelStyle(.default)
		} else {
			AnyUnityEditorVersionLabelStyle(.versionOnly)
		}
	}
}
