enum AddProjectActionError: Error {
	case missingRequiredObject(Any.Type)
	case projectAlreadyExists
	case invalidUnityProject
}
