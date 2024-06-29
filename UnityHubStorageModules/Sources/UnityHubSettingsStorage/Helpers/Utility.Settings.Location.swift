import Foundation
import UnityHubCommon

public extension Utility.Settings {
	enum Location {
		public static func validateInstallationLocation(_ selection: URL?) throws {
			let installationLocation: URL = selection ?? Constant.Settings.Locations.defaultInstallationLocation
			guard (try? installationLocation.checkResourceIsReachable()) == true else {
				throw LocationError.missing
			}
			guard (try? installationLocation.isDirectory()) == true else {
				throw LocationError.invalidType(expected: .isDirectoryKey)
			}
		}

		public static func validateDownloadLocation(_ selection: URL?) throws {
			let downloadLocation: URL = selection ?? Constant.Settings.Locations.defaultDownloadLocation
			guard (try? downloadLocation.checkResourceIsReachable()) == true else {
				throw LocationError.missing
			}
			guard (try? downloadLocation.isDirectory()) == true else {
				throw LocationError.invalidType(expected: .isDirectoryKey)
			}
		}

		public static func validateOfficialHub(_ selection: URL?) throws {
			let officialHubLocation: URL = selection ?? Constant.Settings.Locations.defaultOfficialHubLocation
			guard (try? officialHubLocation.checkResourceIsReachable()) == true else {
				throw LocationError.missing
			}
			guard (try? officialHubLocation.isApplication()) == true else {
				throw LocationError.invalidType(expected: .isApplicationKey)
			}
			let infoPlist: [String: Any] = try Utility.Application.getInfoPlist(from: officialHubLocation)
			let bundleIdentifier = try Utility.Application.getBundleIdentifier(from: infoPlist)
			guard bundleIdentifier == Constant.Settings.Locations.validOfficialHubApplicationBundleIdentifier else {
				throw ApplicationError.invalidBundleIdentifier
			}
			let _ = try Utility.Application.getBundleExecutable(from: infoPlist, at: officialHubLocation)
		}
	}
}
