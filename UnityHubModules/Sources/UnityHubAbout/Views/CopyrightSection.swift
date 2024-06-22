import MoreWindows
import SwiftUI
import UnityHubCommon

struct CopyrightSection: View {
	@Environment(\.openURL) private var openURL

	var body: some View {
		VStack(spacing: 0) {
			Button("\(AppInformation.appName) (Swift) \(AppInformation.copyright ?? "© 2021 Ryan Boyer")") {
				openURL(Constant.Link.ryanBoyer)
			}
			Button("Unity, Unity Hub © Unity Technologies Inc.") {
				openURL(Constant.Link.unity)
			}
		}
		.buttonStyle(.plain)
		.font(.caption)
		.foregroundStyle(.secondary)
	}
}
