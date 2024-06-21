import OSLog
import SwiftUI
import UnityHubCommon
import UnityHubStorage

struct AddProjectList: View {
	@Environment(\.dismiss) private var dismiss

	var body: some View {
		Menu("Add Project", systemImage: Constant.Symbol.plus) {
			Button(
				action: { print("\(Self.self).\(#function) is not implemented") },
				label: Label.create
			)
			.keyboardShortcut(Constant.Hotkey.new)
			.disabled(true)

			Button(
				action: { Event.locateProject(.add) },
				label: Label.locate
			)
			.keyboardShortcut(Constant.Hotkey.open)
		}
	}
}
