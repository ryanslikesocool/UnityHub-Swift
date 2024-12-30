import Combine
import Foundation

protocol Acknowledgement: Sendable & Decodable {
	associatedtype Decoder: TopLevelDecoder where Decoder.Input == Data
	associatedtype ItemView: AcknowledgementItemView where ItemView.A == Self

	static var fileName: String { get }
	static var fileExtension: String { get }

	static var decoder: Decoder { get }

	static var sortComparator: (any SortComparator<Self>)? { get }
	@MainActor static var modelKeyPath: ReferenceWritableKeyPath<AboutSceneModel, [Self]> { get }
}