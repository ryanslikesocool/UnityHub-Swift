import Foundation
import UnityHubCommon
import UnityHubStorage

extension ProjectMetadata {
	static func pinnedComparator(order: SortOrder = .reverse) -> some SortComparator<ProjectMetadata> {
		let innerComparator = BooleanComparator(order: order)
		return KeyPathComparator<Self>(\.pinned, comparator: innerComparator)
	}

	static func projectNameComparator(order: SortOrder = .forward) -> some SortComparator<ProjectMetadata> {
		NameComparator(order: order)
	}

	static func editorVersionComparator(order: SortOrder = .forward) -> some SortComparator<ProjectMetadata> {
		let optionalBehavior: OptionalSortBehavior = .early
		return KeyPathComparator<Self>(\.editorVersion, optionalBehavior: optionalBehavior, order: order)
	}

	static func lastOpenedComparator(order: SortOrder = .forward) -> some SortComparator<ProjectMetadata> {
		let optionalBehavior: OptionalSortBehavior = order == .reverse ? .early : .late
		return KeyPathComparator<Self>(\.lastOpened, optionalBehavior: optionalBehavior, order: order)
	}
}
