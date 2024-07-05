import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

public struct SettingsScene: Scene {
	public init() { }

	public var body: some Scene {
		Settings {
			TabView {
				GeneralTab()
				LocationTab()
				#if DEBUG
				DevelopmentTab()
				#endif
			}
			.formStyle(.grouped)
			.fixedSize()

			.errorReceiver(event: Event.locationError)
			.errorReceiver(event: Event.applicationError)
		}
		.windowID(Self.windowID)
	}
}

// MARK: - Constants

private extension SettingsScene {
	static let windowID: String = "com.DevelopedWithLove.UnityHub.Settings"
}
