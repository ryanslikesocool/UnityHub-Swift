import SwiftUI
import UnityHubCommon
import UnityHubCommonViews

public struct ResourcesView: View {
	public init() { }

	public var body: some View {
		VStack {
			RealLink("Manual", destination: Constant.Link.manual)
			RealLink("Scripting Reference", destination: Constant.Link.scripting)
			RealLink("Unity Learn", destination: Constant.Link.unityLearn)
			RealLink("Unity Blog", destination: Constant.Link.unityBlog)
			RealLink("Release Archive", destination: Constant.Link.releaseArchive)
			RealLink("Discussions", destination: Constant.Link.discussions)
			RealLink("Forums", destination: Constant.Link.forums)
			RealLink("Unity Pulse", destination: Constant.Link.unityPulse)
			RealLink("Unite", destination: Constant.Link.unite)
			RealLink("Unity Asset Store", destination: Constant.Link.unityAssetStore)
			RealLink("On-Demand Training", destination: Constant.Link.onDemandTraining)
			RealLink("Unity Muse", destination: Constant.Link.unityMuse)
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.toolbar {
			Spacer()
		}
	}
}
