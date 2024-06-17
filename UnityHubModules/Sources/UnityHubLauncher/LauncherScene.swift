import SwiftUI

public struct LauncherScene: Scene {
	public init() { }

	public var body: some Scene {
		Window(Self.windowTitle, id: Self.windowID) {
			ContentView()
				.frame(minWidth: 750, minHeight: 400)
		}
		.windowToolbarStyle(.unified)
	}
}

// MARK: - Constants

public extension LauncherScene {
	static let windowTitle: String = "Unity Hub"
	static let windowID: String = "UnityHub.Launcher"
}
