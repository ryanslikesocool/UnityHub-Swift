import Foundation
import OSLog

public extension PropertyListDecoder {
	static let shared: PropertyListDecoder = PropertyListDecoder()

	func attemptDecode<T: Decodable>(_ type: T.Type, from data: Data) -> T? {
		do {
			return try decode(T.self, from: data)
		} catch {
			Logger.module.error("""
			Failed to decode \(T.self) from \(Data.self):
			\(error.localizedDescription)
			""")
			return nil
		}
	}
}
