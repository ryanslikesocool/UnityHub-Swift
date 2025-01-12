import Combine
import Foundation

protocol CreditProtocol: Sendable, Decodable {
	associatedtype TopLevelDecoder: Combine.TopLevelDecoder where TopLevelDecoder.Input == Data
	associatedtype ItemView: CreditItemView where ItemView.C == Self

	static var fileName: String { get }
	static var fileExtension: String { get }

	static var topLevelDecoder: TopLevelDecoder { get }

	static var sortComparator: (any SortComparator<Self>)? { get }
	@MainActor static var modelKeyPath: ReferenceWritableKeyPath<AboutSceneModel, [Self]> { get }
}
