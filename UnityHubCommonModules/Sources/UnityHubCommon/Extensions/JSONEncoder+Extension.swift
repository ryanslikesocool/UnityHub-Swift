import Foundation
import OSLog

public extension JSONEncoder {
	static let shared: JSONEncoder = JSONEncoder()

	func withOutputFormatting(_ outputFormatting: OutputFormatting) -> Self {
		self.outputFormatting = outputFormatting
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
