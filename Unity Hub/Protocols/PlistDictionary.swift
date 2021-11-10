import Foundation

protocol PlistDictionary {
    init()
    init?(_ any: Any?)
    init(dictionary: [String: Any])
    func saveToDictionary() -> [String: Any]
}

extension PlistDictionary {
    init?(_ any: Any?) {
        if let dictionary = any as? [String: Any] {
            self.init(dictionary: dictionary)
		} else {
			return nil
		}
    }
}
