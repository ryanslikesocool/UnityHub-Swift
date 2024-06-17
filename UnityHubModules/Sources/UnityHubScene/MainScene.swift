import SwiftUI
import UnityHubProjectStorage

public struct MainScene: Scene {
	@State private var projectCache: ProjectCache = .shared

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

public extension MainScene {
	static let windowTitle: String = "Unity Hub"
	static let windowID: String = "UnityHub.Launcher"
}
