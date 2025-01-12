/// Determine if two objects implementing ``Swift/Equatable`` are not equal.
///
/// Based on [this approach](https://nilcoalescing.com/blog/CheckIfTwoValuesOfTypeAnyAreEqual/)
/// from Nil Coalescing.
///
/// - Parameters:
///   - lhs: The left side of the operation.
///   - rhs: The right side of the operation.
/// - Returns: `true` if the arguments are not equal; `false` otherwise.
public func areNotEqual(_ lhs: any Equatable, _ rhs: any Equatable) -> Bool {
	return a_as_b(lhs, rhs) || a_as_b(rhs, lhs)

	func a_as_b<A, B>(_ a: A, _ b: borrowing B) -> Bool where
		A: Equatable,
		B: Equatable
	{
		guard let a = a as? B else {
			return true
		}
		return a != b
	}
}

/// Determine if two objects implementing ``Swift/Equatable`` are not equal.
///
/// Based on [this approach](https://nilcoalescing.com/blog/CheckIfTwoValuesOfTypeAnyAreEqual/)
/// from Nil Coalescing.
///
/// - Parameters:
///   - lhs: The left side of the operation.
///   - rhs: The right side of the operation.
/// - Returns: `true` if the arguments are not equal; `false` otherwise.
public func areNotEqual(_ lhs: (any Equatable)?, _ rhs: (any Equatable)?) -> Bool {
	switch (lhs, rhs) {
		case let (lhs?, rhs?): areNotEqual(lhs, rhs)
		case (.none, .none): false
		default: true
	}
}
