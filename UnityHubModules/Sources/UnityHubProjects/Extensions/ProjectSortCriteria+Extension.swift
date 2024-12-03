import Foundation
import UnityHubStorage

extension ProjectSortCriteria {
	func comparator(order: SortOrder) -> any SortComparator<ProjectMetadata> {
		switch self {
			case .name: ProjectMetadata.projectNameComparator(order: order)
			case .editorVersion: ProjectMetadata.editorVersionComparator(order: order)
			case .lastOpened: ProjectMetadata.lastOpenedComparator(order: order)
		}
	}
}
