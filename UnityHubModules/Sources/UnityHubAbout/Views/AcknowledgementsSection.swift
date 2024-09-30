import SwiftUI
import UnityHubCommon
import UnityHubCommonViews

struct AcknowledgementsSection: View {
	public init() { }

	public var body: some View {
		VStack(spacing: 0) {
			Text("Powered By")
				.font(.headline)

			RealLink("MoreWindows", destination: Constant.Link.moreWindows)
		}
	}
}