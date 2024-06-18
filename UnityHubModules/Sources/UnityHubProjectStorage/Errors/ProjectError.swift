import Foundation

public extension ProjectCache {
	enum ProjectError: Error {
		/// Thrown when a project is missing from the cache.
		case missing(URL)

		/// Thrown when a URL does not contain a valid Unity project.
		case invalid

		/// Thrown when the project cache already contains a project URL.
		case alreadyExists
	}
}
