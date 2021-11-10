import Foundation

class Async {
	static func main(body: @escaping () -> Void) {
		DispatchQueue.main.async {
			body()
		}
	}
	
	static func background(body: @escaping () -> Void) {
		DispatchQueue.global(qos: .background).async {
			body()
		}
	}
}
