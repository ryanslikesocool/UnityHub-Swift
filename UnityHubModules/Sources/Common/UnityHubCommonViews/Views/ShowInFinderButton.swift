import SwiftUI

public struct ShowInFinderButton: View {
	private let url: URL

	public init(_ url: URL) {
		self.url = url
	}

	public var body: some View {
		Button(
			String(localized: .common.action.showInFinder),
			image: .finder,
			action: buttonAction
		)
	}
}

// MARK: - Functions

private extension ShowInFinderButton {
	func buttonAction() {
		NSWorkspace.shared.activateFileViewerSelecting([url])
	}
}
