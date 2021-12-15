import Foundation

extension Timer {
	@discardableResult static func delay(_ duration: Double, repeating: Bool = false, action: @escaping (Timer) -> Void) -> Timer {
		return Timer.scheduledTimer(withTimeInterval: duration, repeats: repeating) {
			action($0)
		}
	}

	@discardableResult static func delay(_ duration: Double, repeating: Bool = false, action: @escaping () -> Void) -> Timer {
		return Timer.scheduledTimer(withTimeInterval: duration, repeats: repeating) { _ in
			action()
		}
	}
}
