import Foundation

public enum Shell { }

// MARK: - Utility

public extension Shell {
	@inlinable static func wrapPath(_ path: some StringProtocol) -> String {
		"\"\(path)\""
	}

	@inlinable static func formatURL(_ url: URL) -> String {
		wrapPath(url.path(percentEncoded: false))
	}
}

// MARK: - Execute

public extension Shell {
	/// Execute a shell command.
	@discardableResult static func execute(_ executableURL: URL, arguments: some Sequence<String>) throws -> String {
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

	/// Execute a shell command.
	@discardableResult @inlinable static func execute(_ executableURL: URL, arguments: String...) throws -> String {
		try execute(executableURL, arguments: arguments)
	}
}

// MARK: - ZSH

public extension Shell {
	static let zshExecutable: URL = URL(filePath: "/bin/zsh", directoryHint: .notDirectory)

	@inlinable @discardableResult static func zsh(_ arguments: some Sequence<String>) throws -> String {
		try execute(zshExecutable, arguments: ["-c"] + arguments)
	}

	@inlinable @discardableResult static func zsh(_ arguments: String...) throws -> String {
		try zsh(arguments)
	}
}
