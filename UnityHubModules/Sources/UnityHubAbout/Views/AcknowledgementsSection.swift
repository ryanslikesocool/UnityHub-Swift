import SwiftUI
import UnityHubCommon
import UnityHubCommonViews

struct AcknowledgementsSection: View {
	var body: some View {
		VStack(spacing: 0) {
			Text("Powered By")
				.font(.headline)

			RealLink("MoreWindows", destination: #URL("https://github.com/ryanslikesocool/MoreWindows"))
		}
	}
}
