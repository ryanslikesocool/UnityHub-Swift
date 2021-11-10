import Foundation

extension UserDefaults {
    static func hasKey(_ key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}
