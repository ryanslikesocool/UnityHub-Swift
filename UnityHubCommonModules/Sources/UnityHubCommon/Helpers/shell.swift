import Foundation

public enum Shell {
	/// Execute a shell command.
	@discardableResult public static func execute(_ arguments: String...) throws -> String {
		let task = Process()
		let pipe = Pipe()

		task.standardOutput = pipe
		task.standardError = pipe
		task.arguments = ["-c"] + arguments
		task.executableURL = URL(fileURLWithPath: "/bin/zsh")
		task.standardInput = nil

		try task.run()

		let data = pipe.fileHandleForReading.readDataToEndOfFile()
		let output = String(data: data, encoding: .utf8)!

		return output
	}
}
