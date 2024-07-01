import Foundation
import UnityHubCommon

public extension Utility {
	enum Application {
		public static func getInfoPlist(from applicationURL: URL) throws -> Data {
			let url = applicationURL
				.appending(path: Constant.Application.infoPlistPath, directoryHint: .notDirectory)
			let data: Data
			do {
				data = try Data(contentsOf: url)
			} catch {
				throw ApplicationError.missingInfoPlist(applicationURL: applicationURL)
			}
			return data
		}

		static func getPlistValue<Value: Decodable>(
			key plistKey: String,
			as type: Value.Type = Value.self,
			from applicationURL: borrowing URL
		) throws -> Value {
			let plistData: Data = try getInfoPlist(from: applicationURL)
			return try getPlistValue(key: plistKey, as: type, from: plistData)
		}

		static func getPlistValue<Value: Decodable>(
			key plistKey: String,
			as type: Value.Type = Value.self,
			from plistData: borrowing Data
		) throws -> Value {
			let codingKey = InfoPlistCodingKey(stringValue: plistKey)
			return try PropertyListDecoder.shared.decode(InfoPlist<Value>.self, from: plistData, configuration: codingKey).value
		}

		private struct InfoPlist<Value: Decodable>: DecodableWithConfiguration {
			let value: Value

			public init(from decoder: any Decoder, configuration: InfoPlistCodingKey) throws {
				let container = try decoder.container(keyedBy: InfoPlistCodingKey.self)

				value = try container.decode(forKey: configuration)
			}
		}

		private struct InfoPlistCodingKey: CodingKey {
			let stringValue: String
			let intValue: Int? = nil

			init(stringValue: String) {
				self.stringValue = stringValue
			}

			init?(intValue: Int) { nil }
		}
	}
}

// MARK: - Bundle Version

public extension Utility.Application {
	static func getBundleVersion(from plistData: borrowing Data) throws -> String {
		try getPlistValue(key: Constant.Application.bundleVersionKey, from: plistData)
	}

	static func getBundleVersion(from applicationURL: borrowing URL) throws -> String {
		try getPlistValue(key: Constant.Application.bundleVersionKey, from: applicationURL)
	}

	private struct InfoPlist_BundleVersion: Decodable {
		let value: String

		private enum CodingKeys: String, CodingKey {
			case value

			var rawValue: String { Constant.Application.bundleVersionKey }
		}
	}
}

// MARK: - Bundle Identifier

public extension Utility.Application {
	static func getBundleIdentifier(from plistData: borrowing Data) throws -> String {
		try getPlistValue(key: Constant.Application.bundleIdentifierKey, from: plistData)
	}

	static func getBundleIdentifier(from applicationURL: borrowing URL) throws -> String {
		try getPlistValue(key: Constant.Application.bundleIdentifierKey, from: applicationURL)
	}
}

// MARK: - Bundle Executable

public extension Utility.Application {
	static func getBundleExecutable(from plistData: borrowing Data, at applicationURL: borrowing URL) throws -> URL {
		let bundleExecutable: String = try getPlistValue(key: Constant.Application.bundleExecutableKey, from: plistData)
		return try getBundleExecutable(named: bundleExecutable, at: applicationURL)
	}

	static func getBundleExecutable(from applicationURL: borrowing URL) throws -> URL {
		let plistData: Data = try getInfoPlist(from: applicationURL)
		return try getBundleExecutable(from: plistData, at: applicationURL)
	}

	private static func getBundleExecutable(named bundleExecutable: borrowing String, at applicationURL: borrowing URL) throws -> URL {
		let executableURL = applicationURL
			.appending(path: Constant.Application.executableDirectoryPath, directoryHint: .isDirectory)
			.appending(component: bundleExecutable, directoryHint: .notDirectory)
		guard try executableURL.resourceValues(forKeys: [.isExecutableKey]).isExecutable == true else {
			throw ApplicationError.missingExecutable
		}
		return executableURL
	}
}

// MARK: - LS UI Element

public extension Utility.Application {
	static func getLSUIElement(from plistData: borrowing Data) throws -> Bool? {
		try getPlistValue(key: Constant.Application.lsuiElementKey, from: plistData)
	}

	static func getLSUIElement(from applicationURL: borrowing URL) throws -> Bool? {
		try getPlistValue(key: Constant.Application.lsuiElementKey, from: applicationURL)
	}
}
