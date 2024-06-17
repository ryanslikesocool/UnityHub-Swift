import Foundation
import UnityHubProjectStorage
import UnityHubSettingsStorage

extension Sequence<ProjectMetadata> {
	func sorted(by criteria: ProjectSortCriteria, order: SortOrder = .forward) -> [ProjectMetadata] {
		return switch criteria {
			case .name:
				sorted(by: { lhs, rhs in
					Self.comparePinned(lhs: lhs, rhs: rhs) && Self.compare(\.name, lhs: lhs, rhs: rhs, order: order)
				})
			case .editorVersion:
				sorted(by: { lhs, rhs in
					Self.comparePinned(lhs: lhs, rhs: rhs) && Self.compare(\.editorVersion, lhs: lhs, rhs: rhs, order: order, nilIsFirst: true)
				})
			case .lastOpened:
				sorted(by: { lhs, rhs in
					Self.comparePinned(lhs: lhs, rhs: rhs) && Self.compare(\.lastOpened, lhs: lhs, rhs: rhs, order: order, nilIsFirst: true)
				})
		}
	}
}

private extension Sequence<ProjectMetadata> {
	static func comparePinned(lhs: Element, rhs: Element) -> Bool {
		lhs.pinned && !rhs.pinned
	}

	static func compare<T: Comparable>(
		lhs: T,
		rhs: T,
		order: SortOrder
	) -> Bool {
		switch order {
			case .forward: lhs < rhs
			case .reverse: lhs > rhs
		}
	}

	static func compare<T: Comparable>(
		_ keyPath: KeyPath<Element, T>,
		lhs: Element,
		rhs: Element,
		order: SortOrder
	) -> Bool {
		compare(lhs: lhs[keyPath: keyPath], rhs: rhs[keyPath: keyPath], order: order)
	}

	static func compare<T: Comparable>(
		_ keyPath: KeyPath<Element, T?>,
		lhs: Element,
		rhs: Element,
		order: SortOrder,
		nilIsFirst: Bool
	) -> Bool {
		switch (lhs[keyPath: keyPath], rhs[keyPath: keyPath]) {
			case let (.some(lhs), .some(rhs)): compare(lhs: lhs, rhs: rhs, order: order)
			case (.some, .none): nilIsFirst
			case (.none, .some): !nilIsFirst
			default: true
		}
	}
}
