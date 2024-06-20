import SwiftUI

public enum Constant {
	public enum Symbol {
		public static let cube: String = "cube"
		public static let tray: String = "tray"
		public static let info: String = "info"
		public static let info_circle: String = "info.circle"
		public static let pin: String = "pin"
		public static let pin_fill: String = "pin.fill"
		public static let folder: String = "folder"
		public static let questionMark: String = "questionmark"
		public static let magnifyingGlass: String = "magnifyingglass"
		public static let trash: String = "trash"
		public static let plus: String = "plus"
		public static let eye: String = "eye"
		public static let arrow_up_arrow_down: String = "arrow.up.arrow.down"
		public static let arrow_clockwise: String = "arrow.clockwise"
		public static let square_and_arrow_down: String = "square.and.arrow.down"
		public static let arrow_up: String = "arrow.up"
		public static let arrow_down: String = "arrow.down"
		public static let book_closed: String = "book.closed"
		public static let exclamationMark_triangle_fill: String = "exclamationmark.triangle.fill"
		public static let curlyBraces: String = "curlybraces"
		public static let person: String = "person"
		public static let person_3_sequence: String = "person.3.sequence"
		public static let cloud: String = "cloud"
		public static let gearShape: String = "gearshape"
		public static let ant: String = "ant"

		public static let finder: String = "finder"
		public static let rectangle_portrait_and_arrow_left: String = "rectangle.portrait.and.arrow.left"
	}

	public enum Hotkey {
		public static let new: KeyboardShortcut = KeyboardShortcut("n", modifiers: [.command])
		public static let open: KeyboardShortcut = KeyboardShortcut("o", modifiers: [.command])
		public static let info: KeyboardShortcut = KeyboardShortcut("i", modifiers: [.command])
	}
}
