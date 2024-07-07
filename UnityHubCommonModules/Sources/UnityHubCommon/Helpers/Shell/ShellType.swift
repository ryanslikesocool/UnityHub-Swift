import Foundation

public struct ShellType<Argument: ShellArgumentProtocol> {
	public let executable: URL

	public init(executable: URL) {
		self.executable = executable
	}

	public init(executable: String) {
		self.init(executable: URL(filePath: executable, directoryHint: .notDirectory))
	}
}

// MARK: - Sendable

extension ShellType: Sendable { }

// MARK: - Equatable

extension ShellType: Equatable { }

// MARK: - Hashable

extension ShellType: Hashable { }

// MARK: - Identifiable

extension ShellType: Identifiable {
	public var id: URL { executable }
}

// MARK: -

public extension ShellType {
	@inlinable @discardableResult func callAsFunction(_ arguments: some Sequence<Argument>) throws -> String {
		try Shell.execute(executable, arguments: arguments.map(\.shellArgument))
	}

	@inlinable @discardableResult func callAsFunction(_ arguments: Argument...) throws -> String {
		try callAsFunction(arguments)
	}
}
