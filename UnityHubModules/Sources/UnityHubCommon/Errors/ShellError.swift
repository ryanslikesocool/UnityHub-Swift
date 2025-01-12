public struct ShellError: Error {
	public let rawValue: any Error

	public init(_ rawValue: any Error) {
		self.rawValue = rawValue
	}
}
