import SwiftUI
import UnityHubCommonViews
import UnityHubStorage

extension InstallationList.Item {
	struct VersionLabel: View {
		@AppSetting(installation: \.infoVisibility) private var infoVisibility

		private let version: UnityEditorVersion?

		public init(_ version: UnityEditorVersion?) {
			self.version = version
		}

		public var body: some View {
			if let version {
				UnityEditorVersionLabel(version)
					.unityEditorVersionLabelStyle(editorVersionLabelStyle)
			} else {
				Text("Unknown Version")
					.font(.headline)
			}
		}
	}
}

// MARK: - Supporting Views

private extension InstallationList.Item.VersionLabel {
	var editorVersionLabelStyle: AnyUnityEditorVersionLabelStyle {
		if infoVisibility.contains(.badge) {
			AnyUnityEditorVersionLabelStyle(.default)
		} else {
			AnyUnityEditorVersionLabelStyle(.versionOnly)
		}
	}
}
