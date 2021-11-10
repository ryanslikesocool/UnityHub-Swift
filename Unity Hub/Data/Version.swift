import Foundation

struct Version: Identifiable, CustomStringConvertible {
    static let zero = Version(major: 0, minor: 0, patch: 0)

    var major: UInt
    var minor: UInt
    var patch: UInt

    var description: String { "\(major).\(minor).\(patch)" }
    var id: String { description }
}

extension Version {
    init(string: String) {
        let components = string.components(separatedBy: ".").map { UInt($0) ?? 0 }
        if components.count >= 3 {
            major = components[0]
            minor = components[1]
            patch = components[2]
        } else if components.count == 2 {
            major = components[0]
            minor = components[1]
            patch = 0
        } else if components.count == 1 {
            major = components[0]
            minor = 0
            patch = 0
        } else {
            major = 0
            minor = 0
            patch = 0
        }
    }
}
