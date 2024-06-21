import Foundation

/// Simple, badly implemented Yaml "parser", if it can even be called that.
public enum MiniYaml { }

public extension MiniYaml {
	/// - Remark: The provided key is automatically formatted with a  ": " suffix.
	static func readValue(in url: URL, forKey key: String) throws -> String? {
		let text: String = try String(contentsOf: url)
		return readValue(in: text, forKey: key)
	}

	/// - Remark: The provided key is automatically formatted with a  ": " suffix.
	static func readValue(in text: String, forKey key: String) -> String? {
		let lines = text.components(separatedBy: .newlines)
		return readValue(in: lines, forKey: key)
	}

	/// - Remark: The provided key is automatically formatted with a  ": " suffix.
	static func readValue(in lines: [String], forKey key: String) -> String? {
		let formattedKey: String = "\(key): "
		guard let value =
			lines
				.first(where: { $0.drop(while: { $0.isWhitespace }).starts(with: formattedKey) })?
				.drop(while: { $0.isWhitespace })
				.trimmingPrefix(formattedKey)
		else {
			return nil
		}
		return String(value)
	}
}
