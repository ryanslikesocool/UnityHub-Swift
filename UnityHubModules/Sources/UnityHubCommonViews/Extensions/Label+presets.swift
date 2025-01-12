import SwiftUI
import UnityHubResources

public extension Label where
	Title == Text,
	Icon == Image
{
	static func info() -> Self { Self("Info", systemImage: .info) }
	static func retry() -> Self { Self(String(localized: .common.action.retry), systemImage: .arrow_clockwise) }
	static func menu() -> Self { Self("Menu", image: .ellipsis_vertical) }
	static func reportBug() -> Self { Self(String(localized: .common.action.reportBug), systemImage: .ant) }
	static func add() -> Self { Self(String(localized: .common.action.add), systemImage: .plus) }

	static func pin() -> Self { Self(String(localized: .common.action.pin), systemImage: .pin) }
	static func pinned() -> Self { Self("Pinned", systemImage: .pin) }

	static func visibility() -> Self { Self("Visibility", systemImage: .eye) }
	static func sort() -> Self { Self(String(localized: .common.action.sort), systemImage: .arrow_up_arrow_down) }

	static func showInFinder() -> Self { Self(String(localized: .common.action.showInFinder), image: .finder) }
	static func open() -> Self { Self(String(localized: .common.action.open), systemImage: .arrow_up_forward) }
	static func openWith() -> Self { Self("Open With", systemImage: .list_bullet) }
	static func create() -> Self { Self(String(localized: .common.action.create), systemImage: .plus) }
	static func locate() -> Self { Self(String(localized: .common.action.locate), systemImage: .folder) }
	static func download() -> Self { Self(String(localized: .common.action.download), systemImage: .square_and_arrow_down) }
	static func remove() -> Self { Self(String(localized: .common.action.remove), systemImage: .minus) }
	static func uninstall() -> Self { Self(String(localized: .common.action.uninstall), systemImage: .trash) }

	static func manual() -> Self { Self("Manual", systemImage: .book_closed) }
	static func scriptReference() -> Self { Self("Script Reference", systemImage: .curlyBraces) }

	@MainActor
	static func issue() -> some View {
		Self("Issue", systemImage: .exclamationMark_triangle_fill)
			.symbolRenderingMode(.monochrome)
			.foregroundStyle(.yellow)
			.labelStyle(.iconOnly)
	}
}
