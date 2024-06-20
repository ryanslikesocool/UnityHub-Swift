import Foundation

extension TimeInterval {
	static let secondsPerMinute: Self = 60
	static let secondsPerHour: Self = secondsPerMinute * 60
	static let secondsPerDay: Self = secondsPerHour * 24
	static let secondsPerWeek: Self = secondsPerDay * 7
	static let secondsPerMonth: Self = secondsPerDay * 30
	static let secondsPerYear: Self = secondsPerDay * 365
}
