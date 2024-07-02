import AppKit
import SwiftUI

final class NSCustomSplitViewController: NSSplitViewController {
	init(
		sidebar sidebarProvider: @escaping () -> some View,
		default defaultProvider: @escaping () -> some View
	) {
		super.init(nibName: nil, bundle: nil)

		splitView.dividerStyle = .thin

		let sidebarViewController = NSHostingController(rootView: sidebarProvider())
		let sidebarItem = NSSplitViewItem(sidebarWithViewController: sidebarViewController)
		addSplitViewItem(sidebarItem)

		let defaultViewController = NSHostingController(rootView: defaultProvider())
		let defaultItem = NSSplitViewItem(viewController: defaultViewController)
		addSplitViewItem(defaultItem)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: -

extension NSCustomSplitViewController {
	static func applyWidth(_ value: CustomSplitViewColumnWidth?, to item: NSSplitViewItem) {
		guard let value else {
			return
		}

		switch (value.min, value.max) {
			case let (.some(min), .some(max)):
				item.minimumThickness = min
				item.maximumThickness = max
				item.canCollapse = min != max
			case let (.some(min), .none):
				item.minimumThickness = min
				item.maximumThickness = NSSplitViewItem.unspecifiedDimension
				item.canCollapse = item.behavior == .sidebar || item.behavior == .inspector
			case let (.none, .some(max)):
				item.minimumThickness = NSSplitViewItem.unspecifiedDimension
				item.maximumThickness = max
				item.canCollapse = item.behavior == .sidebar || item.behavior == .inspector
			default:
				item.minimumThickness = NSSplitViewItem.unspecifiedDimension
				item.maximumThickness = NSSplitViewItem.unspecifiedDimension
				item.canCollapse = item.behavior == .sidebar || item.behavior == .inspector
				break
		}
	}
}
