import SwiftUI

public extension Label where
	Title == Text,
	Icon == Image
{
	static func info() -> Self { Self("Info", systemImage: .info) }
	static func retry() -> Self { Self("Retry", systemImage: .arrow_clockwise) }
	static func menu() -> Self { Self("Menu", image: .ellipsis_vertical) }
	static func reportBug() -> Self { Self("Report a Bug", systemImage: .ant) }
	static func add() -> Self { Self("Add", systemImage: .plus) }

	static func pin() -> Self { Self("Pin", systemImage: .pin) }
	static func pinned() -> Self { Self("Pinned", systemImage: .pin) }

	static func visibility() -> Self { Self("Visibility", systemImage: .eye) }
	static func sort() -> Self { Self("Sort", systemImage: .arrow_up_arrow_down) }

	static func showInFinder() -> Self { Self("Show in Finder", image: .finder) }
	static func open() -> Self { Self("Open", systemImage: .arrow_up_forward) }
	static func openWith() -> Self { Self("Open With", systemImage: .list_bullet) }
	static func create() -> Self { Self("Create", systemImage: .plus) }
	static func locate() -> Self { Self("Locate", systemImage: .folder) }
	static func download() -> Self { Self("Download", systemImage: .square_and_arrow_down) }
	static func remove() -> Self { Self("Remove", systemImage: .minus) }
	static func uninstall() -> Self { Self("Uninstall", systemImage: .trash) }

	static func manual() -> Self { Self("Manual", systemImage: .book_closed) }
	static func scriptReference() -> Self { Self("Script Reference", systemImage: .curlyBraces) }

	static func ascending() -> Self { Self("Ascending", systemImage: .arrow_up) }
	static func descending() -> Self { Self("Descending", systemImage: .arrow_down) }

	static func projects() -> Self { Self("Projects", systemImage: .cube) }
	static func installations() -> Self { Self("Installations", systemImage: .tray) }
	static func resources() -> Self { Self("Resources", systemImage: .info_circle) }

	@MainActor
	static func issue() -> some View {
		Self("Issue", systemImage: .exclamationMark_triangle_fill)
			.symbolRenderingMode(.monochrome)
			.foregroundStyle(.yellow)
			.labelStyle(.iconOnly)
	}
}
