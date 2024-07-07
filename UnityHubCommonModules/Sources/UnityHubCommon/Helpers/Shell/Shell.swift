import Foundation

public enum Shell { }

// MARK: -

public extension Shell {
	/// Execute a shell command.
	@discardableResult static func execute(_ executableURL: URL, arguments: some Sequence<String>) throws -> String {
//		print("\(executableURL.path(percentEncoded: false)) \(arguments.joined(separator: " "))")
//		return ""

		let task = Process()
		let pipe = Pipe()

		task.standardOutput = pipe
		task.standardError = pipe
		task.arguments = Array(arguments)
		task.executableURL = executableURL
		task.standardInput = nil

		try task.run()

		let data = pipe.fileHandleForReading.readDataToEndOfFile()
		let output = String(data: data, encoding: .utf8)!

		return output
	}
}
