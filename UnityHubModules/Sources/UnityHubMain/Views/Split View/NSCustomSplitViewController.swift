import AppKit
import SwiftUI

final class NSCustomSplitViewController: NSSplitViewController {
	private static var splitViewIdentifier: String { "com.DevelopedWithLove.RestorationID:CustomSplitViewController" }

	init(
		sidebar sidebarProvider: @escaping () -> some View,
		detail detailProvider: @escaping () -> some View,
		columnWidth: borrowing[CustomSplitViewColumn: CustomSplitViewColumnWidth]
	) {
		let sidebarViewController = NSHostingController(rootView: sidebarProvider())
		let detailViewController = NSHostingController(rootView: detailProvider())

		super.init(nibName: nil, bundle: nil)

		setupController()
		setupViews(
			sidebar: sidebarViewController,
			detail: detailViewController,
			columnWidth: columnWidth
		)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: -

private extension NSCustomSplitViewController {
	func setupController() {
		splitView.dividerStyle = .thin
		splitView.autosaveName = Self.splitViewIdentifier
		splitView.identifier = NSUserInterfaceItemIdentifier(rawValue: Self.splitViewIdentifier)
	}

	func setupViews(
		sidebar sidebarViewController: some NSViewController,
		detail detailViewController: some NSViewController,
		columnWidth: [CustomSplitViewColumn: CustomSplitViewColumnWidth]
	) {
		let sidebarItem = NSSplitViewItem(sidebarWithViewController: sidebarViewController)
		Self.applyWidth(columnWidth[.sidebar], to: sidebarItem)
		addSplitViewItem(sidebarItem)

		let detailItem = NSSplitViewItem(viewController: detailViewController)
		Self.applyWidth(columnWidth[.detail], to: detailItem)
		addSplitViewItem(detailItem)
	}

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
			case let (.none, .some(max)):
				item.maximumThickness = max
			default:
				break
		}
	}
}
