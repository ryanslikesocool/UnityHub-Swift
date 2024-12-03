import SwiftUI

public extension Label where
	Title == Text,
	Icon == Image
{
	static func info() -> Self { Self("Info", systemImage: Symbol.info) }
	static func retry() -> Self { Self("Retry", systemImage: Symbol.arrow_clockwise) }
	static func menu() -> Self { Self("Menu", image: Symbol.ellipsis_vertical) }
	static func reportBug() -> Self { Self("Report a Bug", systemImage: Symbol.ant) }
	static func add() -> Self { Self("Add", systemImage: Symbol.plus) }

	static func pin() -> Self { Self("Pin", systemImage: Symbol.pin) }
	static func pinned() -> Self { Self("Pinned", systemImage: Symbol.pin) }

	static func visibility() -> Self { Self("Visibility", systemImage: Symbol.eye) }
	static func sort() -> Self { Self("Sort", systemImage: Symbol.arrow_up_arrow_down) }

	static func showInFinder() -> Self { Self("Show in Finder", image: Symbol.finder) }
	static func open() -> Self { Self("Open", systemImage: Symbol.arrow_up_forward) }
	static func openWith() -> Self { Self("Open With", systemImage: Symbol.list_bullet) }
	static func create() -> Self { Self("Create", systemImage: Symbol.plus) }
	static func locate() -> Self { Self("Locate", systemImage: Symbol.folder) }
	static func download() -> Self { Self("Download", systemImage: Symbol.square_and_arrow_down) }
	static func remove() -> Self { Self("Remove", systemImage: Symbol.minus) }
	static func uninstall() -> Self { Self("Uninstall", systemImage: Symbol.trash) }

	static func manual() -> Self { Self("Manual", systemImage: Symbol.book_closed) }
	static func scriptReference() -> Self { Self("Script Reference", systemImage: Symbol.curlyBraces) }

	static func ascending() -> Self { Self("Ascending", systemImage: Symbol.arrow_up) }
	static func descending() -> Self { Self("Descending", systemImage: Symbol.arrow_down) }

	static func projects() -> Self { Self("Projects", systemImage: Symbol.cube) }
	static func installations() -> Self { Self("Installations", systemImage: Symbol.tray) }
	static func resources() -> Self { Self("Resources", systemImage: Symbol.info_circle) }

	@MainActor
	static func issue() -> some View {
		Self("Issue", systemImage: Symbol.exclamationMark_triangle_fill)
			.symbolRenderingMode(.monochrome)
			.foregroundStyle(.yellow)
			.labelStyle(.iconOnly)
	}
}
