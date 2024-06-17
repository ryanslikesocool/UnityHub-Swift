import Foundation
import UnityHubProjectStorage
import UnityHubSettingsStorage

extension Sequence<ProjectInfo> {
	func sorted(by criteria: ProjectSortCriteria, order: SortOrder = .forward) -> [ProjectInfo] {
		switch criteria {
			case .name: sorted(by: \.name, order: order)
			case .editorVersion: sorted(by: \.editorVersion, order: order, nilIsFirst: true)
			case .lastOpened: sorted(by: \.lastOpened, order: order, nilIsFirst: true)
		}
	}
}
