import Foundation

public extension KeyedDecodingContainer {
	func decode<T>(forKey key: Key) throws -> T where
		T: Decodable
	{
		try decode(T.self, forKey: key)
	}

	func decodeIfPresent<T>(forKey key: Key) throws -> T? where
		T: Decodable
	{
		try decodeIfPresent(T.self, forKey: key)
	}
}
