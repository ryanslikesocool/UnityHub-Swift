import MoreWindows
import SwiftUI

struct CopyrightSection: View {
	var body: some View {
		VStack {
			Text(AppInformation.copyright ?? "© 2021 Ryan Boyer")

			Text("""
			Developed With Love
			Colorado, USA
			MMXXI
			""")
			.foregroundStyle(.secondary)
			Image("heart.pixel")
				.foregroundStyle(Color("developedwithlove.red"))
		}
		.multilineTextAlignment(.center)
	}
}
