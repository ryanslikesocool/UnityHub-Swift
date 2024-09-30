import SwiftUI
import UnityHubCommon
import UnityHubStorage

struct AddInstallationList: View {
	public init() { }

	public var body: some View {
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
		DownloadInstallationButton()
		LocateInstallationButton()
	}
}
