public extension ProjectCache {
	enum AddProjectError: Error {
		case projectAlreadyExists
		case invalidUnityProject
	}
}
