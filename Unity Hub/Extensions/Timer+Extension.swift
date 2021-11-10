import Foundation

extension Timer {
	@discardableResult static func delay(_ duration: Double, action: @escaping (Timer) -> Void) -> Timer {
		return Timer.scheduledTimer(withTimeInterval: duration, repeats: false) {
			action($0)
		}
	}
	
	@discardableResult static func delay(_ duration: Double, action: @escaping () -> Void) -> Timer {
		return Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { _ in
			action()
		}
	}
}
