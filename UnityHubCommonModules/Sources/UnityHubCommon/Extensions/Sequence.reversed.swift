public extension Sequence {
	func reversed(if condition: Bool) -> [Element] {
		if condition {
			reversed()
		} else {
			Array(self)
		}
	}
}
