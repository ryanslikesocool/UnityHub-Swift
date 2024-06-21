import Foundation
import UnityHubCommon

public extension Utility {
	enum Installation {
		static func isValidBundleIdentifier(_ bundleIdentifier: String) -> Bool {
			bundleIdentifier == Constant.Installation.validApplicationBundleIdentifier
		}

		static func getInfoPlistURL(appURL: URL) -> URL {
			appURL
				.appending(path: Constant.Installation.infoPlistPath, directoryHint: .notDirectory)
		}

		public static func getBugReporterURL(appURL: URL) -> URL {
			appURL
				.deletingLastPathComponent()
				.appending(path: Constant.Installation.bugReporterPath, directoryHint: .notDirectory)
		}

		static func getModulesURL(appURL: URL) -> URL {
			appURL
				.deletingLastPathComponent()
				.appending(path: Constant.Installation.modulesJSONPath, directoryHint: .notDirectory)
		}

		static func getExecutableURL(appURL: URL, infoPlist: InstallationInfoPlist) -> URL {
			appURL
				.appending(path: Constant.Installation.executableDirectoryPath, directoryHint: .isDirectory)
				.appending(component: infoPlist.executable, directoryHint: .notDirectory)
		}

		public static func getExecutableURL(appURL: URL) throws -> URL {
			let infoPlist = try getInfoPlist(appURL: appURL)
			return getExecutableURL(appURL: appURL, infoPlist: infoPlist)
		}

		static func getInfoPlist(appURL: URL) throws -> InstallationInfoPlist {
			let infoPlistURL: URL = getInfoPlistURL(appURL: appURL)
			let data = try Data(contentsOf: infoPlistURL)
			return try PropertyListDecoder.shared.decode(InstallationInfoPlist.self, from: data)
		}

		@discardableResult public static func validateInstallation(appURL: URL) throws -> Bool {
			let fileManager: FileManager = .default

			guard
				fileManager.fileExists(at: appURL)
			else {
				throw InstallationError.missingInstallationAtURL(appURL)
			}

			/// - NOTE: do not convert to `lazy var`.  increases build time to unknown amount (at least 300 seconds)
			let infoPlist = try getInfoPlist(appURL: appURL)

			guard try getExecutableURL(appURL: appURL, infoPlist: infoPlist).isExecutable() else {
				throw InstallationError.missingInstallationAtURL(appURL)
			}

			guard isValidBundleIdentifier(infoPlist.bundleIdentifier) else {
				throw InstallationError.invalidBundleIdentifier
			}

			return true
		}
	}
}
