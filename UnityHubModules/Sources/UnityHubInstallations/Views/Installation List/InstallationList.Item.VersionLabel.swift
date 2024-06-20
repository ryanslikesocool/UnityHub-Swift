import SwiftUI
import UnityHubCommonViews
import UnityHubStorage

extension InstallationList.Item {
	struct VersionLabel: View {
		private let version: UnityEditorVersion?

		init(_ version: UnityEditorVersion?) {
			self.version = version
		}

		var body: some View {
			if let version {
				UnityEditorVersionLabel(version)
			} else {
				Text("Unknown Version")
					.font(.headline)
			}
		}
	}
}
