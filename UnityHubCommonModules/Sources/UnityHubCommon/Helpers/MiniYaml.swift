import Foundation

/// A simple, badly implemented Yaml "decoder", if it can even be called that.
/// - Remark: This has actually measured faster than using a library like [Yams](https://github.com/jpsim/Yams) because we don't need type information or structure.
public enum MiniYaml {
	/// - Remark: The provided key is automatically formatted with a  ": " suffix.
	/// - Parameters:
	///   - url: The URL pointing to the text to decode.
	///   - key: The key to search for.
	/// - Returns: The value associated with the given key, if it exists; `nil` otherwise.
	public static func readValue(in url: URL, forKey key: String) throws -> String? {
		let text: String = try String(contentsOf: url)
		return readValue(in: text, forKey: key)
	}

	/// - Remark: The provided key is automatically formatted with a  ": " suffix.
	/// - Parameters:
	///   - text: The text to decode.
	///   - key: The key to search for.
	/// - Returns: The value associated with the given key, if it exists; `nil` otherwise.
	public static func readValue(in text: String, forKey key: String) -> String? {
		let lines = text.components(separatedBy: .newlines)
		return readValue(in: lines, forKey: key)
	}

	/// - Remark: The provided key is automatically formatted with a  ": " suffix.
	/// - Parameters:
	///   - lines: The lines to decode.
	///   - key: The key to search for.
	/// - Returns: The value associated with the given key, if it exists; `nil` otherwise.
	public static func readValue(in lines: [String], forKey key: String) -> String? {
		let formattedKey: String = "\(key): "
		guard let value =
			lines
				.first(where: { line in line.drop(while: \.isWhitespace).starts(with: formattedKey) })?
				.drop(while: \.isWhitespace)
				.trimmingPrefix(formattedKey)
		else {
			return nil
		}
		return String(value)
	}
}
