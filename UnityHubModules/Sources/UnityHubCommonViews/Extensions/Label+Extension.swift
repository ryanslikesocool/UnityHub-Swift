import SwiftUI
import UnityHubCommon

public extension Label<Text, EmptyView> {
	init(_ title: some StringProtocol) {
		self.init(title: { Text(title) }, icon: EmptyView.init)
	}

	init(_ titleKey: LocalizedStringKey) {
		self.init(title: { Text(titleKey) }, icon: EmptyView.init)
	}
}

// MARK: - Presets

public extension Label<Text, Image> {
	static func info() -> Self { Self("Info", systemImage: Constant.Symbol.info) }
	static func retry() -> Self { Self("Retry", systemImage: Constant.Symbol.arrow_clockwise) }
	static func menu() -> Self { Self("Menu", image: Constant.Symbol.ellipsis_vertical) }
	static func reportBug() -> Self { Self("Report a Bug", systemImage: Constant.Symbol.ant) }

	static func pin() -> Self { Self("Pin", systemImage: Constant.Symbol.pin) }
	static func pinned() -> Self { Self("Pinned", systemImage: Constant.Symbol.pin) }

	static func visibility() -> Self { Self("Visibility", systemImage: Constant.Symbol.eye) }
	static func sort() -> Self { Self("Sort", systemImage: Constant.Symbol.arrow_up_arrow_down) }

	static func showInFinder() -> Self { Self("Show in Finder", image: Constant.Symbol.finder) }
	static func open() -> Self { Self("Open", systemImage: Constant.Symbol.arrow_up_forward) }
	static func openWith() -> Self { Self("Open With", systemImage: Constant.Symbol.list_bullet) }
	static func create() -> Self { Self("Create", systemImage: Constant.Symbol.plus) }
	static func locate() -> Self { Self("Locate", systemImage: Constant.Symbol.folder) }
	static func download() -> Self { Self("Download", systemImage: Constant.Symbol.square_and_arrow_down) }
	static func remove() -> Self { Self("Remove", systemImage: Constant.Symbol.minus) }
	static func uninstall() -> Self { Self("Uninstall", systemImage: Constant.Symbol.trash) }

	static func manual() -> Self { Self("Manual", systemImage: Constant.Symbol.book_closed) }
	static func scriptReference() -> Self { Self("Script Reference", systemImage: Constant.Symbol.curlyBraces) }

	static func ascending() -> Self { Self("Ascending", systemImage: Constant.Symbol.arrow_up) }
	static func descending() -> Self { Self("Descending", systemImage: Constant.Symbol.arrow_down) }

	static func projects() -> Self { Self("Projects", systemImage: Constant.Symbol.cube) }
	static func installations() -> Self { Self("Installations", systemImage: Constant.Symbol.tray) }
	static func resources() -> Self { Self("Resources", systemImage: Constant.Symbol.info_circle) }
}
