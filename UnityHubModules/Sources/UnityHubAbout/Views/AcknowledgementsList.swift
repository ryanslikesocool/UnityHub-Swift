import SwiftUI
import UnityHubCommon
import UnityHubCommonViews

struct AcknowledgementsList: View {
	public init() { }

	public var body: some View {
		VStack(spacing: 0) {
			Text("Powered By")
				.font(.headline)

			RealLink("MoreWindows", destination: Constant.Link.moreWindows)
			RealLink("UserIcon", destination: Constant.Link.userIcon)
			RealLink("UnityHub", destination: Constant.Link.officialUnityHub)
		}
	}
}
