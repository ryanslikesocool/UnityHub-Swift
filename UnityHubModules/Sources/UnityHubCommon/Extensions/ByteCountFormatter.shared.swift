import Foundation

public extension ByteCountFormatter {
	nonisolated(unsafe) static let shared: ByteCountFormatter = ByteCountFormatter()
}
