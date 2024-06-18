import SwiftUI

public struct ResourcesView: View {
	public init() { }

	public var body: some View {
		VStack {
			Link("Unity Learn", destination: URL(string: "https://learn.unity.com/")!)

			Link("Unity Blog", destination: URL(string: "https://blog.unity.com")!)

			Link("Release Archive", destination: URL(string: "https://unity.com/releases/editor/archive")!)

			Link("Discussions", destination: URL(string: "https://discussions.unity.com")!)

			Link("Forums", destination: URL(string: "https://forum.unity.com")!)

			Link("Unity Pulse", destination: URL(string: "https://unity.com/unity-pulse")!)

			Link("Unite", destination: URL(string: "https://unity.com/unite")!)

			Link("Unity Asset Store", destination: URL(string: "https://assetstore.unity.com")!)

			Link("On-Demand Training", destination: URL(string: "https://unity.com/products/on-demand-training")!)

			Link("Unity Muse", destination: URL(string: "https://unity.com/muse")!)
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
	}
}
