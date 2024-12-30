import SwiftUI
import UnityHubCommon
import UnityHubCommonViews

public struct ResourcesView: View {
	public init() { }

	public var body: some View {
		VStack {
			RealLink("Manual", destination: .unityResource.manual)
			RealLink("Scripting Reference", destination: .unityResource.scripting)
			RealLink("Unity Learn", destination: .unityResource.unityLearn)
			RealLink("Unity Blog", destination: .unityResource.unityBlog)
			RealLink("Release Archive", destination: .unityResource.releaseArchive)
			RealLink("Discussions", destination: .unityResource.discussions)
			RealLink("Forums", destination: .unityResource.forums)
			RealLink("Unity Pulse", destination: .unityResource.unityPulse)
			RealLink("Unite", destination: .unityResource.unite)
			RealLink("Unity Asset Store", destination: .unityResource.unityAssetStore)
			RealLink("On-Demand Training", destination: .unityResource.onDemandTraining)
			RealLink("Unity Muse", destination: .unityResource.unityMuse)
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.toolbar {
			Spacer()
		}
	}
}
