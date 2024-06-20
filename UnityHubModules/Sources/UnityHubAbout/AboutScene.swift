import MoreWindows
import SwiftUI

public struct AboutScene: Scene {
	public init() { }

	public var body: some Scene {
		About {
			AcknowledgementsSection()
			VStack {
				CopyrightSection()
				DevelopedWithLoveSection()
			}
		}
	}
}
