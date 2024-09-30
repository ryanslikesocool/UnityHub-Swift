import Foundation
import UnityHubCommon

public extension Utility.Settings {
	enum Location {
		public static func validateInstallationLocation(_ selection: URL?) throws {
			let installationLocation: URL = selection ?? Constant.Settings.Location.defaultInstallationLocation
			guard (try? installationLocation.checkResourceIsReachable()) == true else {
				throw LocationError.missing
			}
			guard (try? installationLocation.checkIsDirectory()) == true else {
				throw LocationError.invalidType(expected: .isDirectoryKey)
			}
		}

		public static func validateDownloadLocation(_ selection: URL?) throws {
			let downloadLocation: URL = selection ?? Constant.Settings.Location.defaultDownloadLocation
			guard (try? downloadLocation.checkResourceIsReachable()) == true else {
				throw LocationError.missing
			}
			guard (try? downloadLocation.checkIsDirectory()) == true else {
				throw LocationError.invalidType(expected: .isDirectoryKey)
			}
		}

		public static func validateOfficialHub(_ selection: URL?) throws {
			let officialHubLocation: URL = selection ?? Constant.Settings.Location.defaultOfficialHubLocation
			guard (try? officialHubLocation.checkResourceIsReachable()) == true else {
				throw LocationError.missing
			}
			guard (try? officialHubLocation.checkIsApplication()) == true else {
				throw LocationError.invalidType(expected: .isApplicationKey)
			}
			let infoPlist: Data = try Utility.Application.getInfoPlist(from: officialHubLocation)
			let bundleIdentifier = try Utility.Application.getBundleIdentifier(from: infoPlist)
			guard bundleIdentifier == Constant.Application.UnityHub.validOfficialHubApplicationBundleIdentifier else {
				throw ApplicationError.invalidBundleIdentifier
			}
			_ = try Utility.Application.getBundleExecutable(from: infoPlist, at: officialHubLocation)
		}
	}
}
