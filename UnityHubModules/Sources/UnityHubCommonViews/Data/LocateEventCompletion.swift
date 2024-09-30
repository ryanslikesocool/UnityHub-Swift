import Foundation

public enum LocateEventCompletion {
	case add
	case replace(URL)
}

// MARK: - Sendable

extension LocateEventCompletion: Sendable { }

// MARK: - Equatable

extension LocateEventCompletion: Equatable { }

// MARK: - Hashable

extension LocateEventCompletion: Hashable { }
