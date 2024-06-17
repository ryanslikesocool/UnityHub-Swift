import MoreWindows
import SwiftUI

public struct AboutScene: Scene {
	public init() { }

	public var body: some Scene {
		About {
			AppInfoSection()
				.appInfoSectionStyle(.custom)
				.frame(width: 350, height: 200)
		}
		.aboutWindowLayout(.custom)
	}
}
