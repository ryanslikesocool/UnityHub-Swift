import SwiftUI
import UnityHubCommon
import UnityHubStorage

struct AddInstallationList: View {
	var body: some View {
		Menu(
			content: makeContent,
			label: Label.add
		)
	}
}

// MARK: - Supporting Views

private extension AddInstallationList {
	@ViewBuilder
	func makeContent() -> some View {
		Button.downloadInstallation()
		Button.locateInstallation()
	}
}
