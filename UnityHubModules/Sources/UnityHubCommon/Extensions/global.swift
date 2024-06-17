public func preconditionFailure(missingObject objectType: Any.Type, function: String = #function) -> Never {
	preconditionFailure("""
	Cannot execute \(#function) because a required object of type \(objectType) is missing.
	Crashing because this should never happen, and something is seriously wrong...
	""")
}
