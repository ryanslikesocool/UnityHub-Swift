import SwiftUI

public struct SettingsButton: View {
	public init() { }

	public var body: some View {
		SettingsLink {
			Label("Settings", image: Symbol.gearShape)
		}
		.keyboardShortcut(.settings)
	}
}