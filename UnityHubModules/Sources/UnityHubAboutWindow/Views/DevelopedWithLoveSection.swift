import SwiftUI
import UnityHubCommon
import UnityHubCommonViews

struct DevelopedWithLoveSection: View {
	@Environment(\.openURL) private var openURL

	var body: some View {
		Button(action: { openURL(.acknowledgements.developedWithLove) }) {
			VStack {
				Text("""
				Developed With Love
				Colorado, USA
				""")
				.font(.caption.monospaced())
				.foregroundStyle(.tertiary)
				.multilineTextAlignment(.center)

				Image(.heart_pixel_fill)
					.foregroundStyle(Color.developedWithLove_red)
			}
		}
		.buttonStyle(.plain)
	}
}
