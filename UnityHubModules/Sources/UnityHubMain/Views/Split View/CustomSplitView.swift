import AppKit
import SwiftUI

struct CustomSplitView<Sidebar: View, Detail: View>: NSViewControllerRepresentable {
	typealias SidebarProvider = () -> Sidebar
	typealias DetailProvider = () -> Detail
	
	@Environment(\.customSplitViewColumnWidth) private var columnWidth

	private let sidebar: SidebarProvider
	private let detail: DetailProvider

	init(
		@ViewBuilder sidebar: @escaping SidebarProvider,
		@ViewBuilder detail: @escaping DetailProvider
	) {
		self.sidebar = sidebar
		self.detail = detail
	}

	func makeNSViewController(context: Context) -> NSCustomSplitViewController {
		let nsViewController = NSCustomSplitViewController(
			sidebar: sidebar,
			default: detail
		)

		DispatchQueue.main.async {
			Self.updateItems(in: nsViewController, with: columnWidth)
		}

		return nsViewController
	}

	func updateNSViewController(_ nsViewController: NSCustomSplitViewController, context: Context) { 
		Self.updateItems(in: nsViewController, with: columnWidth)
	}

	private static func updateItems(in nsViewController: NSCustomSplitViewController, with columnWidth: [NSSplitViewItem.Behavior : CustomSplitViewColumnWidth]) {
		for (key, value) in columnWidth {
			guard let item = nsViewController.splitViewItems.first(where: { $0.behavior == key }) else {
				continue
			}

			NSCustomSplitViewController.applyWidth(value, to: item)
		}
	}
}
