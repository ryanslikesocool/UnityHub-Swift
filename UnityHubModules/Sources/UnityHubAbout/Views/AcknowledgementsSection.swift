import SwiftUI
import UnityHubCommon

struct AcknowledgementsSection: View {
	var body: some View {
		VStack(spacing: 0) {
			Text("Powered By")
				.font(.headline)

			Link("MoreWindows", destination: #URL("https://github.com/ryanslikesocool/MoreWindows"))
		}
	}
}
