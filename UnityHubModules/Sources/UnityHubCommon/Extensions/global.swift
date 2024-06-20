public func preconditionFailure(missingObject objectType: Any.Type, file: String = #file, line: Int = #line) -> Never {
	preconditionFailure("""
	\(file)@\(line)
	A required object of type \(objectType) is missing.
	""")
}

public func preconditionFailure(unexpectedError error: Error, file: String = #file, line: Int = #line) -> Never {
	preconditionFailure("""
	\(file)@\(line)
	Caught an unexpected error:
	\(error.localizedDescription)
	""")
}
