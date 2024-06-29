import SwiftUI

public extension ToolbarItem<String, Divider> {
	static func sidebarTrackingSeparator(placement: ToolbarItemPlacement) -> Self {
		ToolbarItem(id: NSToolbarItem.Identifier.sidebarTrackingSeparator.rawValue, placement: placement, content: Divider.init)
	}
}
