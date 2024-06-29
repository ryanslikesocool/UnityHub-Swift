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
		NSCustomSplitViewController(
			sidebar: sidebar,
			detail: detail,
			columnWidth: columnWidth
		)
	}

	func updateNSViewController(_ nsViewController: NSCustomSplitViewController, context: Context) { }
}
