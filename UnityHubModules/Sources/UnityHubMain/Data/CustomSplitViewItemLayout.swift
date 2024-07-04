import AppKit

struct CustomSplitViewItemLayout {
	let behavior: NSSplitViewItem.Behavior
	let min: CGFloat
	let max: CGFloat
	let collapsible: Bool

	init(
		_ behavior: NSSplitViewItem.Behavior,
		min: CGFloat? = nil,
		max: CGFloat? = nil,
		collapsible: Bool? = nil
	) {
		self.behavior = behavior

		switch (min, max) {
			case let (.some(min), .some(max)):
				self.min = min
				self.max = max
				self.collapsible = collapsible ?? (min != max)
			case let (.some(min), .none):
				self.min = min
				self.max = NSSplitViewItem.unspecifiedDimension
				self.collapsible = collapsible ?? (behavior == .sidebar || behavior == .inspector)
			case let (.none, .some(max)):
				self.min = NSSplitViewItem.unspecifiedDimension
				self.max = max
				self.collapsible = collapsible ?? (behavior == .sidebar || behavior == .inspector)
			default:
				self.min = NSSplitViewItem.unspecifiedDimension
				self.max = NSSplitViewItem.unspecifiedDimension
				self.collapsible = collapsible ?? (behavior == .sidebar || behavior == .inspector)
		}
	}
}
