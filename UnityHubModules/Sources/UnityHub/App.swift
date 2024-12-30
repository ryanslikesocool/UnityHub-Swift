import SwiftUI
import UnityHubAboutWindow
import UnityHubMainWindow
import UnityHubSettingsWindow

@main
public struct App: SwiftUI.App {
	public init() { }

	public var body: some Scene {
		MainScene()
		AboutScene()
		SettingsScene()
	}
}
