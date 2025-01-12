import MoreWindows
import SwiftUI
import UnityHubCommon

struct CopyrightSection: View {
	@Environment(\.openURL) private var openURL

	public init() { }

	public var body: some View {
		VStack(spacing: Self.spacing) {
			applicationCopyright()
			unityCopyright()
		}
		.font(Self.font)
		.foregroundStyle(Self.textStyle)
		.buttonStyle(Self.buttonStyle)
	}
}

// MARK: - Constants

private extension CopyrightSection {
	static let spacing: CGFloat = 0

	static var font: Font { .caption }
	static var textStyle: some ShapeStyle { .secondary }
	static var buttonStyle: some PrimitiveButtonStyle { .plain }
}

// MARK: - Supporting Views

private extension CopyrightSection {
	@ViewBuilder
	func applicationCopyright() -> some View {
		if let copyrightHolder = Bundle.main.copyright {
			Button(
				LocalizedStringResource.aboutWindow.copyright.application(copyrightHolder: copyrightHolder)
			) {
				openURL(.acknowledgements.ryanBoyer)
			}
		}
	}

	func unityCopyright() -> some View {
		Button(
			String(localized: .aboutWindow.copyright.unity)
		) {
			openURL(.acknowledgements.unity)
		}
	}
}
