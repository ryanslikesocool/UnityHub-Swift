import Foundation
import UnityHubCommon

public extension Utility {
	enum Application {
		public static func getInfoPlist(from applicationURL: URL) throws -> [String: Any] {
			let data: Data = try getInfoPlist(from: applicationURL)
			guard let result = try PropertyListSerialization.propertyList(from: data, format: nil) as? [String: Any] else {
				throw ApplicationError.infoPlistDeserializationFailure
			}
			return result
		}

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
	}
}

// MARK: - Bundle Version

public extension Utility.Application {
	static func getBundleVersion(from plist: borrowing [String: Any]) throws -> String {
		let plistKey: String = Constant.Application.bundleVersionKey
		guard let result = plist[plistKey] as? String else {
			throw ApplicationError.missingInfoPlistKey(plistKey)
		}
		return result
	}

	static func getBundleVersion(from plistData: borrowing Data) throws -> String {
		let plist: InfoPlist_BundleVersion = try PropertyListDecoder.shared.decode(InfoPlist_BundleVersion.self, from: plistData)
		return plist.value
	}

	static func getBundleVersion(from applicationURL: borrowing URL) throws -> String {
		let plistData: Data = try getInfoPlist(from: applicationURL)
		return try getBundleVersion(from: plistData)
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
	static func getBundleIdentifier(from plist: borrowing [String: Any]) throws -> String {
		let plistKey: String = Constant.Application.bundleIdentifierKey
		guard let result = plist[plistKey] as? String else {
			throw ApplicationError.missingInfoPlistKey(plistKey)
		}
		return result
	}

	static func getBundleIdentifier(from plistData: borrowing Data) throws -> String {
		let plist: InfoPlist_BundleIdentifier = try PropertyListDecoder.shared.decode(InfoPlist_BundleIdentifier.self, from: plistData)
		return plist.value
	}

	static func getBundleIdentifier(from applicationURL: borrowing URL) throws -> String {
		let plistData: Data = try getInfoPlist(from: applicationURL)
		return try getBundleIdentifier(from: plistData)
	}

	private struct InfoPlist_BundleIdentifier: Decodable {
		let value: String

		private enum CodingKeys: String, CodingKey {
			case value

			var rawValue: String { Constant.Application.bundleIdentifierKey }
		}
	}
}

// MARK: - Bundle Executable

public extension Utility.Application {
	static func getBundleExecutable(from plist: borrowing [String: Any], at applicationURL: borrowing URL) throws -> URL {
		let plistKey: String = Constant.Application.bundleExecutableKey
		guard let bundleExecutable = plist[plistKey] as? String else {
			throw ApplicationError.missingInfoPlistKey(plistKey)
		}
		let executableURL = applicationURL
			.appending(path: Constant.Application.executableDirectoryPath, directoryHint: .isDirectory)
			.appending(component: bundleExecutable, directoryHint: .notDirectory)
		guard try executableURL.resourceValues(forKeys: [.isExecutableKey]).isExecutable == true else {
			throw ApplicationError.missingExecutable
		}
		return executableURL
	}

	static func getBundleExecutable(from plistData: borrowing Data, at applicationURL: borrowing URL) throws -> URL {
		let plist: InfoPlist_BundleExecutable = try PropertyListDecoder.shared.decode(InfoPlist_BundleExecutable.self, from: plistData)
		let executableURL = applicationURL
			.appending(path: Constant.Application.executableDirectoryPath, directoryHint: .isDirectory)
			.appending(component: plist.value, directoryHint: .notDirectory)
		guard try executableURL.resourceValues(forKeys: [.isExecutableKey]).isExecutable == true else {
			throw ApplicationError.missingExecutable
		}
		return executableURL
	}

	static func getBundleExecutable(from applicationURL: borrowing URL) throws -> URL {
		let plistData: Data = try getInfoPlist(from: applicationURL)
		return try getBundleExecutable(from: plistData, at: applicationURL)
	}

	private struct InfoPlist_BundleExecutable: Decodable {
		let value: String

		private enum CodingKeys: String, CodingKey {
			case value

			var rawValue: String { Constant.Application.bundleExecutableKey }
		}
	}
}
