import SFSymbolToolbox
import SwiftUI
import UnityHubCommon
import UnityHubCommonViews

struct DevelopedWithLoveSection: View {
	@Environment(\.openURL) private var openURL

	var body: some View {
		Button(action: buttonAction) {
			VStack {
				Text(.aboutWindow.developedWithLove)
					.font(Self.font)
					.foregroundStyle(Self.textStyle)
					.multilineTextAlignment(Self.textAlignment)

				Image(Self.iconResource)
					.foregroundStyle(Self.iconStyle)
			}
		}
		.buttonStyle(Self.buttonStyle)
	}
}

// MARK: - Constants

private extension DevelopedWithLoveSection {
	static var font: Font { .caption.monospaced() }
	static var textStyle: some ShapeStyle { .tertiary }
	static let textAlignment: TextAlignment = .center

	static var iconResource: ImageResource { .heart_pixel_fill }
	static var iconStyle: some ShapeStyle { Color.developedWithLove_red }

	static var buttonStyle: some PrimitiveButtonStyle { .plain }
}

// MARK: - Functions

private extension DevelopedWithLoveSection {
	func buttonAction() {
		openURL(.acknowledgements.developedWithLove)
	}
}
