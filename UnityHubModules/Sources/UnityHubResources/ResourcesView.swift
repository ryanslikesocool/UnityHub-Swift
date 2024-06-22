import SwiftUI
import UnityHubCommon

public struct ResourcesView: View {
	public init() { }

	public var body: some View {
		VStack {
			Link("Manual", destination: Constant.Link.manual)
			Link("Scripting Reference", destination: Constant.Link.scripting)
			Link("Unity Learn", destination: Constant.Link.unityLearn)
			Link("Unity Blog", destination: Constant.Link.unityBlog)
			Link("Release Archive", destination: Constant.Link.releaseArchive)
			Link("Discussions", destination: Constant.Link.discussions)
			Link("Forums", destination: Constant.Link.forums)
			Link("Unity Pulse", destination: Constant.Link.unityPulse)
			Link("Unite", destination: Constant.Link.unite)
			Link("Unity Asset Store", destination: Constant.Link.unityAssetStore)
			Link("On-Demand Training", destination: Constant.Link.onDemandTraining)
			Link("Unity Muse", destination: Constant.Link.unityMuse)
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
	}
}
