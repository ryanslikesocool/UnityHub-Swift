import Foundation
import UnityHubStorageProjects

extension ProjectMetadata {
	struct NameComparator: SortComparator {
		public typealias Compared = ProjectMetadata

		public var order: SortOrder

		public init(order: SortOrder = .forward) {
			self.order = order
		}

		public func compare(_ lhs: Compared, _ rhs: Compared) -> ComparisonResult {
			// fall back to directory name if necessary
			let comparisonResult = ComparisonResult(
				lhs.name ?? lhs.url.lastPathComponent,
				rhs.name ?? rhs.url.lastPathComponent
			)

			return switch order {
				case .forward: comparisonResult
				case .reverse: comparisonResult.inverse
			}
		}
	}
}
