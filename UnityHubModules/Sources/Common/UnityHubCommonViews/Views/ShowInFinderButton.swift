import SwiftUI

public struct ShowInFinderButton: View {
	private let url: URL

	public init(_ url: URL) {
		self.url = url
	}

	public var body: some View {
		Button(action: buttonAction) {
			Label {
				Text("Show in Finder")
			} icon: {
				Image("finder")
			}
		}
	}
}

// MARK: - Functions

private extension ShowInFinderButton {
	func buttonAction() {
		NSWorkspace.shared.activateFileViewerSelecting([url])
	}
}
