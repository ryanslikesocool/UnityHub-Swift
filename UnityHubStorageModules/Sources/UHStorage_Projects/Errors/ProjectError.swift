import Foundation

public enum ProjectError: Error {
	/// Thrown when a project is missing from the cache.
	case missing(URL)

	/// Thrown when a URL does not point to a valid Unity project.
	case invalid

	/// Thrown when the project cache already contains a project URL.
	case alreadyExists

	case unknownEditorVersion
}
