import MoreWindows
import SwiftUI

public struct AboutScene: Scene {
	public init() { }

	public var body: some Scene {
		About(content: ContentView.init)
//			.aboutWindowLayout(.custom)
			.aboutWindowOptions(.none)
	}
}
