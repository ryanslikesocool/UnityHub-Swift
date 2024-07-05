import OSLog

public enum Measure {
	public typealias Action = () throws -> Void
	public typealias AsyncAction = () async throws -> Void

	/// Measure a unit of work and log the time elapsed to the console.
	@inlinable public static func measure(_ label: String, file: StaticString = #file, line: UInt = #line, _ work: Action) rethrows {
		let clock = ContinuousClock()
		let duration = try clock.measure(work)
		log(label: label, duration: duration, file: file, line: line)
	}

	/// Measure a unit of work and log the time elapsed to the console.
	@inlinable public static func measure(file: StaticString = #file, line: UInt = #line, _ work: Action) rethrows {
		let clock = ContinuousClock()
		let duration = try clock.measure(work)
		log(duration: duration, file: file, line: line)
	}

	/// Measure a unit of work and log the time elapsed to the console.
	@inlinable public static func measure(_ label: String, file: StaticString = #file, line: UInt = #line, _ work: AsyncAction) async rethrows {
		let clock = ContinuousClock()
		let duration = try await clock.measure(work)
		log(label: label, duration: duration, file: file, line: line)
	}

	/// Measure a unit of work and log the time elapsed to the console.
	@inlinable public static func measure(file: StaticString = #file, line: UInt = #line, _ work: AsyncAction) async rethrows {
		let clock = ContinuousClock()
		let duration = try await clock.measure(work)
		log(duration: duration, file: file, line: line)
	}
}

extension Measure {
	@usableFromInline static func log(label: String, duration: Duration, file: StaticString, line: UInt) {
		logger.debug("Took \(duration.formatted(formatStyle)) to execute work '\(label)' in \(file)@\(line).")
	}

	@usableFromInline static func log(duration: Duration, file: StaticString, line: UInt) {
		logger.debug("Took \(duration.formatted(formatStyle)) to execute work in \(file)@\(line).")
	}

	@usableFromInline static let formatStyle: Duration.UnitsFormatStyle = Duration.UnitsFormatStyle(
		allowedUnits: [.seconds, .milliseconds],
		width: .abbreviated,
		fractionalPart: .show(length: 7)
	)

	@usableFromInline static let logger: Logger = Logger(subsystem: "Measure", category: "Measure")
}
