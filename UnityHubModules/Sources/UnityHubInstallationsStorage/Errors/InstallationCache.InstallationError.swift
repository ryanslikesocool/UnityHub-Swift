import Foundation

public extension InstallationCache {
	enum InstallationError: Error {
		/// Thrown when an installation is missing from the cache.
		case missing(URL)

		/// Thrown when a URL does not point to a valid Unity editor application.
		case invalid

		/// Thrown when the installation cache already contains an installation URL.
		case alreadyExists
	}
}
