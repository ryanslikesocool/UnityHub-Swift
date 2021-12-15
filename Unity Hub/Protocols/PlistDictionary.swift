import Foundation

protocol PlistDictionary {
	init()
	init(any: Any?)
	init(dictionary: [String: Any])
	func saveToDictionary() -> [String: Any]
}

extension PlistDictionary {
	init(any: Any?) {
		guard let dictionary = any as? [String: Any] else {
			self.init()
			return
		}
		self.init(dictionary: dictionary)
	}
}
