import AppKit
import SwiftUI

struct CustomSplitView<Sidebar: View, Detail: View>: NSViewControllerRepresentable {
	typealias SidebarProvider = () -> Sidebar
	typealias DetailProvider = () -> Detail

	private let sidebar: SidebarProvider
	private let detail: DetailProvider

	init(
		@ViewBuilder sidebar: @escaping SidebarProvider,
		@ViewBuilder detail: @escaping DetailProvider
	) {
		self.sidebar = sidebar
		self.detail = detail
	}

	func makeNSViewController(context: Context) -> _ViewController {
		let controller = _ViewController(sidebar: sidebar, detail: detail)

		return controller
	}

	func updateNSViewController(_ nsViewController: _ViewController, context: Context) { }
}

// MARK: - NSCustomSplitViewController

extension CustomSplitView {
	final class _ViewController: NSSplitViewController {
		private static var splitViewIdentifier: String { "com.DevelopedWithLove.RestorationID:CustomSplitViewController" }

		private let sidebarViewController: NSHostingController<Sidebar>
		private let detailViewController: NSHostingController<Detail>

		fileprivate init(
			sidebar sidebarProvider: @escaping SidebarProvider,
			detail detailProvider: @escaping DetailProvider
		) {
			sidebarViewController = NSHostingController(rootView: sidebarProvider())
			detailViewController = NSHostingController(rootView: detailProvider())

			super.init(nibName: nil, bundle: nil)

			setupController()
			setupViews()
		}

		@available(*, unavailable)
		required init?(coder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}

		private func setupController() {
			splitView.dividerStyle = .thin
			splitView.autosaveName = Self.splitViewIdentifier
			splitView.identifier = NSUserInterfaceItemIdentifier(rawValue: Self.splitViewIdentifier)
		}

		private func setupViews() {
			let sidebarItem = NSSplitViewItem(sidebarWithViewController: sidebarViewController)
			sidebarItem.minimumThickness = 160
			sidebarItem.maximumThickness = 160
			sidebarItem.canCollapse = false
			addSplitViewItem(sidebarItem)

			let detailItem = NSSplitViewItem(viewController: detailViewController)
			detailItem.minimumThickness = 500
			addSplitViewItem(detailItem)
		}
	}
}
