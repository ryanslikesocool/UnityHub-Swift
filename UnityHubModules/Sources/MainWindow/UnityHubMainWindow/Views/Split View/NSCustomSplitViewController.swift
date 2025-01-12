import AppKit
import OSLog
import SwiftUI

/// ## See Also
/// - ``CustomSplitView``
final class NSCustomSplitViewController: NSSplitViewController {
	private var snapPositions: [Int: CustomSplitViewSnapPosition]

	init(
		sidebar sidebarProvider: @escaping () -> some View,
		default defaultProvider: @escaping () -> some View,
		defaultThickness: [NSSplitViewItem.Behavior: CGFloat]
	) {
		snapPositions = [:]

		super.init(nibName: nil, bundle: nil)

		let sidebarViewController = NSHostingController(rootView: sidebarProvider())
		let sidebarItem = NSSplitViewItem(sidebarWithViewController: sidebarViewController)
		addSplitViewItem(sidebarItem)

		let defaultViewController = NSHostingController(rootView: defaultProvider())
		let defaultItem = NSSplitViewItem(viewController: defaultViewController)
		addSplitViewItem(defaultItem)

		for (key, value) in defaultThickness {
			guard let item = splitViewItems.first(where: { $0.behavior == key }) else {
				continue
			}
			let view = item.viewController.view
			view.setFrameSize(CGSize(width: value, height: view.frame.height))
		}
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - NSSplitViewController

extension NSCustomSplitViewController {
	override func splitView(
		_ splitView: NSSplitView,
		constrainSplitPosition proposedPosition: CGFloat,
		ofSubviewAt dividerIndex: Int
	) -> CGFloat {
		guard
			let snapPositions = snapPositions[dividerIndex],
			!splitViewItems[dividerIndex].canCollapse
		else {
			// not supported
			return proposedPosition
		}

		for i in snapPositions.positions.indices.dropLast() {
			let range = snapPositions.positions[i] ... snapPositions.positions[i + 1]
			if range.contains(proposedPosition) {
				let threshold: CGFloat = (range.lowerBound + range.upperBound) * 0.5

				if proposedPosition < threshold {
					snapPositions.onChange?(i)
					return range.lowerBound
				} else {
					snapPositions.onChange?(i + 1)
					return range.upperBound
				}
			}
		}

		return proposedPosition
	}
}

// MARK: -

extension NSCustomSplitViewController {
	func updateItems(with itemLayout: some Sequence<CustomSplitViewItemLayout>) {
		for value in itemLayout {
			guard let item = splitViewItems.first(where: { $0.behavior == value.behavior }) else {
				continue
			}

			item.minimumThickness = value.min
			item.maximumThickness = value.max
			item.canCollapse = value.collapsible
		}
	}

	func updateSnapPositions(with snapPositions: [Int: CustomSplitViewSnapPosition]) {
		let itemCount = splitViewItems.count
		self.snapPositions = snapPositions.filter { index, _ in
			guard index < itemCount else {
				Logger.module.warning("Split view divider index \(index) is outside the range [0 ..< \(itemCount)].")
				return false
			}
			return true
		}.reduce(into: [Int: CustomSplitViewSnapPosition]()) { result, pair in
			let index = pair.key
			var snapPositions = pair.value.positions
			let item: NSSplitViewItem = splitViewItems[index]

			if snapPositions.isEmpty {
				snapPositions.append(item.minimumThickness)
				snapPositions.append(item.maximumThickness)
			}

			snapPositions.sort()

			if snapPositions.first != item.minimumThickness {
				snapPositions.insert(item.minimumThickness, at: 0)
			}
			if snapPositions.last != item.maximumThickness {
				snapPositions.append(item.maximumThickness)
			}

			result[index] = CustomSplitViewSnapPosition(positions: snapPositions, onChange: pair.value.onChange)
		}
	}
}
