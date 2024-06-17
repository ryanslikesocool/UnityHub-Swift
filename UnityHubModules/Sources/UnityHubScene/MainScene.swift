import SwiftUI
import UnityHubStorage
import MoreWindows

public struct MainScene: Scene {
	@State private var projectCache: ProjectCache = .shared

	public init() { }

	public var body: some Scene {
		Window(Self.windowTitle, id: Self.windowID) {
			ContentView()
				.frame(minWidth: 750, minHeight: 400)
		}
		.windowToolbarStyle(.unified)
		.windowID(Self.windowID)
	}
}

// MARK: - Constants

public extension MainScene {
	static let windowTitle: String = "Unity Hub"
	static let windowID: String = "UnityHub.Launcher"
}
