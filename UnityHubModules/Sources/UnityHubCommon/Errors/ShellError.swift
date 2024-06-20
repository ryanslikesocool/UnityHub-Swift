public struct ShellError: Error {
	public let rawValue: Error

	public init(_ rawValue: Error) {
		self.rawValue = rawValue
	}
}
