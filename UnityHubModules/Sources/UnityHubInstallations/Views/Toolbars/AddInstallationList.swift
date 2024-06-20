import SwiftUI
import UnityHubCommon
import UnityHubStorage

struct AddInstallationList: View {
	var body: some View {
		Menu("Add Installation", systemImage: Constant.Symbol.plus) {
			Group {
				Button(
					action: { print("\(Self.self).\(#function) is not implemented") },
					label: Label.download
				)
				.keyboardShortcut(Constant.Hotkey.new)
				.disabled(true)

				Button(
					action: { Event.locateInstallation(.add) },
					label: Label.locate
				)
				.keyboardShortcut(Constant.Hotkey.open)
			}
			.labelStyle(.titleAndIcon)
		}
	}
}
