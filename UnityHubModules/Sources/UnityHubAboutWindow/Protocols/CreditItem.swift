import Combine
import Foundation
import SwiftUI

protocol CreditItem: Sendable, Decodable {
	associatedtype TopLevelDecoder: Combine.TopLevelDecoder where TopLevelDecoder.Input == Data
	associatedtype ItemView: CreditItemView where ItemView.Item == Self

	static var label: Text { get }

//	static var fileName: String { get }
//	static var fileExtension: String { get }

	/// The location of the file containing the acknowledgements.
	static var fileURL: URL? { get }

	/// The top-level decoder used to decode the file at ``fileURL``.
	static var topLevelDecoder: TopLevelDecoder { get }

	/// The sort comparator used to sort the items in the UI.
	/// Leave this value `nil` to leave the items unsorted.
	static var sortComparator: (any SortComparator<Self>)? { get }

	@MainActor
	static var modelKeyPath: ReferenceWritableKeyPath<AboutSceneModel, [Self]> { get }
}

// MARK: - Default Implementation

extension CreditItem {
	static var sortComparator: (any SortComparator<Self>)? {
		nil
	}
}
