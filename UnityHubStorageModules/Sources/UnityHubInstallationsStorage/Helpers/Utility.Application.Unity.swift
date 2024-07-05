import Foundation
import UnityHubCommon
import UnityHubSettingsStorage
import UnityHubStorageCommon

public extension Utility.Application {
	enum Unity {
		public static func getBugReporterURL(for applicationURL: URL) -> URL {
			applicationURL
				.deletingLastPathComponent()
				.appending(path: Constant.Application.Unity.bugReporterPath, directoryHint: .notDirectory)
		}

		static func getModulesURL(for applicationURL: URL) -> URL {
			applicationURL
				.deletingLastPathComponent()
				.appending(path: Constant.Application.Unity.modulesJSONPath, directoryHint: .notDirectory)
		}

		public static var defaultInstallationURL: URL {
			LocationSettings.shared.installationLocation
				?? Constant.Settings.Location.defaultInstallationLocation
		}

		@discardableResult public static func validateInstallation(at applicationURL: URL) throws -> Bool {
			let fileManager: FileManager = .default

			guard
				fileManager.fileExists(at: applicationURL)
			else {
				throw InstallationError.missingInstallationAtURL(applicationURL)
			}

			let infoPlist: Data = try Utility.Application.getInfoPlist(from: applicationURL)
			_ = try Utility.Application.getBundleExecutable(from: infoPlist, at: applicationURL)
			let bundleIdentifier: String = try Utility.Application.getBundleIdentifier(from: infoPlist)

			guard bundleIdentifier == Constant.Application.Unity.validBundleIdentifier else {
				throw InstallationError.invalidBundleIdentifier
			}

			return true
		}
	}
}
