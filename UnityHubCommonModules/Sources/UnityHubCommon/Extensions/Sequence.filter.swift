public extension Sequence {
	func filter<T: Equatable>(
		by keyPath: borrowing KeyPath<Element, T>,
		equals equalityValue: T
	) -> [Element] {
		filter { element in
			element[keyPath: keyPath] == equalityValue
		}
	}

	func filter<T: Equatable>(
		by keyPath: borrowing KeyPath<Element, T?>,
		equals equalityValue: T
	) -> [Element] {
		filter { element in
			element[keyPath: keyPath] == equalityValue
		}
	}
}
