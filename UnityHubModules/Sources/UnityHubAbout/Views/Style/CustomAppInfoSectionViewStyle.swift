import MoreWindows
import SwiftUI

struct CustomAppInfoSectionViewStyle: AppInfoSectionStyle {
	func makeBody(configuration: Configuration) -> some View {
		HStack {
			configuration.icon
				.frame(width: 160)

			VStack(alignment: .leading) {
				configuration.name
					.font(.title.bold())
				configuration.version

				Spacer()

				AcknowledgementsSection()
				CopyrightSection()
			}
		}
		.padding(.bottom, 22)
	}
}

extension AppInfoSectionStyle where Self == CustomAppInfoSectionViewStyle {
	static var custom: Self { Self() }
}
