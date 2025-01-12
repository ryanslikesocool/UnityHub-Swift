import SwiftUI

public struct SettingsButton: View {
	public init() { }

	public var body: some View {
		SettingsLink {
			Label("Settings", systemImage: .gearShape)
		}
		.keyboardShortcut(.settings)
	}
}
