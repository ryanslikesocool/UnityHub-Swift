import MoreWindows
import SwiftUI

struct CopyrightSection: View {
	var body: some View {
		VStack {
			Text(AppInformation.copyright ?? "© 2021 Ryan Boyer")
				.font(.caption)
				.foregroundStyle(.secondary)

			Text("""
			Developed With Love
			Colorado, USA
			""")
			.font(.caption.monospaced())
			.foregroundStyle(.tertiary)

			Image("heart.pixel.fill")
				.foregroundStyle(Color("developedwithlove.red"))
		}
		.multilineTextAlignment(.center)
	}
}
