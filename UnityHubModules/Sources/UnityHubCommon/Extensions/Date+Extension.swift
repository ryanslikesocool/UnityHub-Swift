import Foundation

public extension Date {
	func formatDistance(to other: Date) -> String {
		let seconds: TimeInterval = abs(timeIntervalSinceReferenceDate - other.timeIntervalSinceReferenceDate)
		let unit: String
		let interval: Double

		switch seconds {
			case let seconds where seconds < TimeInterval.secondsPerMinute:
				interval = seconds
				unit = "second"
			case let seconds where seconds < TimeInterval.secondsPerHour:
				interval = seconds / TimeInterval.secondsPerMinute
				unit = "minute"
			case let seconds where seconds < TimeInterval.secondsPerDay:
				interval = seconds / TimeInterval.secondsPerHour
				unit = "hour"
			case let seconds where seconds < TimeInterval.secondsPerWeek:
				interval = seconds / TimeInterval.secondsPerDay
				unit = "day"
			case let seconds where seconds < TimeInterval.secondsPerMonth:
				interval = seconds / TimeInterval.secondsPerWeek
				unit = "week"
			case let seconds where seconds < TimeInterval.secondsPerYear:
				interval = seconds / TimeInterval.secondsPerMonth
				unit = "month"
			default:
				interval = seconds / TimeInterval.secondsPerYear
				unit = "year"
		}

		let flooredInterval = Int(interval)
		return "\(flooredInterval) \(unit)\(flooredInterval != 1 ? "s" : "")"
	}
}
