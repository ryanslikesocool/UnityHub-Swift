import MoreWindows
import SwiftUI
import UnityHubStorageProjects

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
		.commands {
			CommandGroup(replacing: .undoRedo) { }
			CommandGroup(replacing: .systemServices) { }
		}
	}
}

// MARK: - Constants

public extension MainScene {
	static let windowTitle: String = "Unity Hub"
	static let windowID: String = "com.DevelopedWithLove.UnityHub.Main"
}
