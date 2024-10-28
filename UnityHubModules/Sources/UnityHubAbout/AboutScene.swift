import MoreWindows
import SwiftUI

public struct AboutScene: Scene {
	public init() { }

	public var body: some Scene {
		About {
			AcknowledgementsSection()

			VStack(spacing: AboutScene.groupSpacing) {
				CopyrightSection()
				DevelopedWithLoveSection()
			}
		}
		.aboutWindowLayout(.vertical(spacing: 24))
	}
}

// MARK: - Constants

extension AboutScene {
	static let groupSpacing: CGFloat = 8
}