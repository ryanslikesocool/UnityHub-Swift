import MoreWindows
import SwiftUI
import UnityHubCommon

struct CopyrightSection: View {
	@Environment(\.openURL) private var openURL

	public init() { }

	public var body: some View {
		VStack(spacing: 0) {
			developerCopyright()
			unityCopyright()
		}
		.buttonStyle(.plain)
		.font(.caption)
		.foregroundStyle(.secondary)
	}
}

// MARK: - Supporting Views

private extension CopyrightSection {
	func developerCopyright() -> some View {
		let bundle = Bundle.main
		let copyright = bundle.copyright ?? "© 2021 Ryan Boyer"

		return Button {
			openURL(Constant.Link.ryanBoyer)
		} label: {
			Text("Unity Hub (Swift) \(copyright)")
		}
	}

	func unityCopyright() -> some View {
		Button {
			openURL(Constant.Link.unity)
		} label: {
			Text("Unity, Unity Hub © Unity Technologies Inc.")
		}
	}
}