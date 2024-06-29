import CoreGraphics

struct CustomSplitViewColumnWidth {
	let min: CGFloat?
	let max: CGFloat?

	init(min: CGFloat? = nil, max: CGFloat? = nil) {
		self.min = min
		self.max = max
	}
}
