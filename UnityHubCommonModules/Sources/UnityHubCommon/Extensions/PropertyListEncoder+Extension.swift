import Foundation
import OSLog

public extension PropertyListEncoder {
	static let shared: PropertyListEncoder = PropertyListEncoder()

	func withFormat(_ format: PropertyListSerialization.PropertyListFormat) -> Self {
		outputFormat = format
		return self
	}

	func attemptEncode<T: Encodable>(_ object: T) -> Data? {
		do {
			return try encode(object)
		} catch {
			Logger.module.error("""
			Failed to encode \(T.self) to \(Data.self):
			\(error.localizedDescription)
			""")
			return nil
		}
	}
}
