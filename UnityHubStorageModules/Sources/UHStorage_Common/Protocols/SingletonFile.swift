import Combine
import Foundation
import OSLog

public protocol SingletonFile: LocalFile {
	@MainActor
	static var shared: Self { get }

	static var fileURL: URL { get }

	init()

	@MainActor
	static func read(_ subscriber: @autoclosure @escaping () -> AnyCancellable) -> Self
	
	func write()
}

// MARK: - Default Implementation

public extension SingletonFile {
	@MainActor
	static func read(
		_ subscriber: @autoclosure @escaping () -> AnyCancellable
	) -> Self {
		let fileURL: URL = Self.fileURL

		defer {
			DispatchQueue.main.async {
				_ = subscriber()
			}
		}

		do {
			return try Self.read(from: fileURL)
		} catch {
			Logger.module.error("""
			Failed to read file:
			- Type: \(Self.self)
			- URL: \(fileURL)
			- Error: \(error)
			""")
			return Self()
		}
	}

	func write() {
		let fileURL: URL = Self.fileURL

		do {
			try write(to: fileURL)
		} catch {
			Logger.module.error("""
			Failed to write file:
			- Type: \(Self.self)
			- URL: \(fileURL)
			- Error: \(error)
			""")
		}
	}
}
