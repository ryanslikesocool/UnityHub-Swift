import Foundation

public enum InstallationError: Error {
	/// Thrown when an installation is missing from the cache.
	case missingInstallationAtURL(URL)

	/// Thrown when an installation is missing for a version.
	case missingInstallationForVersion(UnityEditorVersion)

	/// Thrown when a URL does not point to a valid Unity editor application.
	case invalid

	/// Thrown when the installation cache already contains an installation URL.
	case alreadyExists

	/// Thrown when the Unity version is unknown.
	case unknownVersion(URL)
}
