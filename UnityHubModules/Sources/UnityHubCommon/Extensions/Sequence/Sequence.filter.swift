public extension Sequence {
	func filter<Value>(
		by keyPath: borrowing KeyPath<Element, Value>,
		equals equalityValue: Value
	) -> [Element] where
		Value: Equatable
	{
		filter { element in
			element[keyPath: keyPath] == equalityValue
		}
	}

	func filter<Value>(
		by keyPath: borrowing KeyPath<Element, Value?>,
		equals equalityValue: Value
	) -> [Element] where
		Value: Equatable
	{
		filter { element in
			element[keyPath: keyPath] == equalityValue
		}
	}
}
