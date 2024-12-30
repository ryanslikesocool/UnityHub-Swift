/// Determine if two objects implementing ``Swift/Equatable`` are equal.
///
/// Based on [this approach](https://nilcoalescing.com/blog/CheckIfTwoValuesOfTypeAnyAreEqual/)
/// from Nil Coalescing.
/// 
/// - Parameters:
///   - lhs: The left side of the operation.
///   - rhs: The right side of the operation.
/// - Returns: `true` if the arguments are equal; `false` otherwise.
public func areEqual(_ lhs: any Equatable, _ rhs: any Equatable) -> Bool {
	return a_as_b(lhs, rhs) || a_as_b(rhs, lhs)

	func a_as_b<A, B>(_ a: A, _ b: borrowing B) -> Bool where
		A: Equatable,
		B: Equatable
	{
		guard let a = a as? B else {
			return false
		}
		return a == b
	}
}

/// Determine if two objects implementing ``Swift/Equatable`` are equal.
///
/// Based on [this approach](https://nilcoalescing.com/blog/CheckIfTwoValuesOfTypeAnyAreEqual/)
/// from Nil Coalescing.
///
/// - Parameters:
///   - lhs: The left side of the operation.
///   - rhs: The right side of the operation.
/// - Returns: `true` if the arguments are equal; `false` otherwise.
public func areEqual(_ lhs: (any Equatable)?, _ rhs: (any Equatable)?) -> Bool {
	switch (lhs, rhs) {
		case let (lhs?, rhs?): areEqual(lhs, rhs)
		case (.none, .none): true
		default: false
	}
}
