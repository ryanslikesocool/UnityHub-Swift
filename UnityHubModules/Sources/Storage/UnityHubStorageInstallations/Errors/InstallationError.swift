import Foundation
import UnityHubCommon

public enum InstallationError: Error {
	/// Thrown when an installation is missing from the cache.
	case missingInstallationAtURL(URL)

	/// Thrown when an installation is missing for a version.
	case missingInstallationForVersion(UnityEditorVersion)

	/// Thrown when a URL does not point to a valid Unity editor application.
	case invalid

	/// Thrown when an editor's bundle identifier is invalid.
	/// 
	/// - SeeAlso:
	///   - ``Constant/Installation/validApplicationBundleIdentifier``
	case invalidBundleIdentifier

	/// Thrown when the installation cache already contains an installation URL.
	case alreadyExists

	/// Thrown when the Unity version is unknown.
	case unknownVersion(URL)
}
