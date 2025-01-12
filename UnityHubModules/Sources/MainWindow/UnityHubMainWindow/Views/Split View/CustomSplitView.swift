import AppKit
import SwiftUI

/// ## Topics
/// - ``NSCustomSplitViewController``
///
/// ### Environment
/// - ``SwiftUICore/EnvironmentValues/customSplitViewDefaultThickness``
/// - ``SwiftUICore/EnvironmentValues/customSplitViewItemLayout``
/// - ``SwiftUICore/EnvironmentValues/customSplitViewSnapPositions``
struct CustomSplitView<Sidebar, Detail>: NSViewControllerRepresentable where
	Sidebar: View,
	Detail: View
{
	typealias SidebarProvider = () -> Sidebar
	typealias DetailProvider = () -> Detail

	@Environment(\.customSplitViewItemLayout) private var itemLayout
	@Environment(\.customSplitViewDefaultThickness) private var defaultThickness
	@Environment(\.customSplitViewSnapPositions) private var snapPositions

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
			default: detail,
			defaultThickness: defaultThickness
		)

		DispatchQueue.main.async {
			nsViewController.updateItems(with: itemLayout.values)
			nsViewController.updateSnapPositions(with: snapPositions)
		}

		return nsViewController
	}

	func updateNSViewController(_ nsViewController: NSCustomSplitViewController, context: Context) { }
}
