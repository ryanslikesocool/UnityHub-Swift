import MoreWindows
import SwiftUI

public struct AboutScene: Scene {
	@StateObject private var model: AboutSceneModel = AboutSceneModel()

	public init() { }

	public var body: some Scene {
		About {
			AcknowledgementsSection()

			VStack(spacing: AboutScene.groupSpacing) {
				CopyrightSection()
				DevelopedWithLoveSection()
			}
		}
		.aboutWindowLayout(Self.windowLayout)
		.environmentObject(model)
	}
}

// MARK: - Constants

extension AboutScene {
	static let windowLayout: AboutWindowLayout = .vertical(spacing: 24)
	static let groupSpacing: CGFloat = 8
}
