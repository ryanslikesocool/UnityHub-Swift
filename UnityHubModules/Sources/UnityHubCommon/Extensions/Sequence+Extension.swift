import SwiftUI

public extension Sequence {
	func sorted<T: Comparable>(
		by keyPath: KeyPath<Element, T>
	) -> [Element] {
		sorted(by: keyPath, areInIncreasingOrder: <)
	}

	func sorted<T: Comparable>(
		by keyPath: KeyPath<Element, T>,
		areInIncreasingOrder: (T, T) throws -> Bool
	) rethrows -> [Element] {
		try sorted { lhs, rhs in
			try areInIncreasingOrder(lhs[keyPath: keyPath], rhs[keyPath: keyPath])
		}
	}

	func sorted<T: Comparable>(
		by keyPath: KeyPath<Element, T?>,
		nilIsFirst: Bool = false
	) -> [Element] {
		sorted(by: keyPath, areInIncreasingOrder: <, nilIsFirst: nilIsFirst)
	}

	func sorted<T: Comparable>(
		by keyPath: KeyPath<Element, T?>,
		areInIncreasingOrder: (T, T) throws -> Bool,
		nilIsFirst: Bool = false
	) rethrows -> [Element] {
		try sorted { lhs, rhs in
			switch (lhs[keyPath: keyPath], rhs[keyPath: keyPath]) {
				case let (.some(lhs), .some(rhs)): try areInIncreasingOrder(lhs, rhs)
				case (.none, .some): nilIsFirst
				case (.some, .none): !nilIsFirst
				default: true
			}
		}
	}

	func sorted<T: Comparable>(
		by keyPath: KeyPath<Element, T>,
		order: SortOrder
	) -> [Element] {
		switch order {
			case .forward: sorted(by: keyPath, areInIncreasingOrder: <)
			case .reverse: sorted(by: keyPath, areInIncreasingOrder: >)
		}
	}

	func sorted<T: Comparable>(
		by keyPath: KeyPath<Element, T?>,
		order: SortOrder,
		nilIsFirst: Bool = false
	) -> [Element] {
		switch order {
			case .forward: sorted(by: keyPath, areInIncreasingOrder: <, nilIsFirst: nilIsFirst)
			case .reverse: sorted(by: keyPath, areInIncreasingOrder: >, nilIsFirst: nilIsFirst)
		}
	}

	func reversed(if condition: Bool) -> [Element] {
		if condition {
			reversed()
		} else {
			Array(self)
		}
	}
}
