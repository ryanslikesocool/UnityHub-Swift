import SwiftUI

struct DevelopedWithLoveSection: View {
	var body: some View {
		VStack {
			Text("""
			Developed With Love
			Colorado, USA
			""")
			.font(.caption.monospaced())
			.foregroundStyle(.tertiary)
			.multilineTextAlignment(.center)

			Image("heart.pixel.fill")
				.foregroundStyle(Color("developedwithlove.red"))
		}
	}
}
