import CoreGraphics

struct CustomSplitViewSnapPosition {
	let positions: [CGFloat]
	let onChange: ((Int) -> Void)?

	init?(
		positions: [CGFloat]?,
		onChange: ((Int) -> Void)?
	) {
		guard let positions else {
			return nil
		}
		self.positions = positions
		self.onChange = onChange
	}
}
