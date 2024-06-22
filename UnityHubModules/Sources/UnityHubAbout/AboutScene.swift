import MoreWindows
import SwiftUI

public struct AboutScene: Scene {
	public init() { }

	public var body: some Scene {
		About {
			AcknowledgementsSection()
			VStack(spacing: 8) {
				CopyrightSection()
				DevelopedWithLoveSection()
			}
		}
	}
}
