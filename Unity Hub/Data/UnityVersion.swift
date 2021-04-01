//
//  UnityVersion.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/23/20.
//

import AppKit
import Foundation

struct UnityVersion {
    var version: String
    var major: Int
    var minor: Int
    var update: Int
    var channel: String
    var iteration: Int
    var installing: Bool
    var lts: Bool
    var path: String
    var modules: [ModuleJSON]

    // a: alpha
    // b: beta
    // f: final (official)
    // p: patch
    // c: china
    static let versionRegex = try! NSRegularExpression(pattern: #"^(\d+)\.(\d+)\.(\d+)([a|b|f|p|c])(\d+)"#)
    static let null = UnityVersion("0.0.0a0")

    var installedModules: [UnityModule] { return modules.filter { $0.selected && (UnityModule(rawValue: $0.id) != Optional.none) }.map { UnityModule(rawValue: $0.id) ?? .none }}

    init() {
        self.version = "0.0.0a0"
        self.major = 0
        self.minor = 0
        self.update = 0
        self.channel = ""
        self.iteration = 0
        self.installing = false
        self.lts = false
        self.path = #"/Applications/Unity/Hub/Editor/0.0.0a0"#
        self.modules = []
    }

    init(_ version: String, path: String = "") {
        self.version = version
        self.major = 0
        self.minor = 0
        self.update = 0
        self.channel = ""
        self.iteration = 0
        self.installing = false
        self.lts = false
        self.path = path.replacingOccurrences(of: #" "#, with: #"\ "#)
        self.modules = []

        UnityVersion.versionRegex.enumerateMatches(in: version, options: [], range: NSRange(0 ..< version.count)) { match, _, stop in
            guard let match = match else { return }

            if match.numberOfRanges == 6,
               let range1 = Range(match.range(at: 1), in: version),
               let range2 = Range(match.range(at: 2), in: version),
               let range3 = Range(match.range(at: 3), in: version),
               let range4 = Range(match.range(at: 4), in: version),
               let range5 = Range(match.range(at: 5), in: version)
            {
                self.major = Int(String(version[range1])) ?? 0
                self.minor = Int(String(version[range2])) ?? 0
                self.update = Int(String(version[range3])) ?? 0
                self.channel = String(version[range4])
                self.iteration = Int(String(version[range5])) ?? 0
                stop.pointee = true
            } else {
                print("UnityVersion \(version) is not a valid unity version")
            }
        }

        self.lts = isLts()
        self.modules = ModuleJSON.getModuleData(path)
    }

    func getBranch() -> String {
        return "\(major).\(minor)"
    }

    func isOfficial() -> Bool {
        return isCorrectChannel(channelChar: "f")
    }

    func isAlpha() -> Bool {
        return isCorrectChannel(channelChar: "a")
    }

    func isBeta() -> Bool {
        return isCorrectChannel(channelChar: "b")
    }

    func isPrerelease() -> Bool {
        return isAlpha() || isBeta()
    }

    func isLts() -> Bool {
        return ((major == 2017 || major == 2018 || major == 2019) && minor == 4)
            || ((major == 2020 || major == 2021) && minor == 3)
    }
}

// MARK: - Validation

extension UnityVersion {
    func isCorrectChannel(channelChar: String) -> Bool {
        var correct: Bool = false
        UnityVersion.versionRegex.enumerateMatches(in: version, options: [], range: NSRange(0 ..< version.count)) { match, _, _ in
            guard let match = match else { return }
            correct = String(version[Range(match.range(at: 4), in: version) ?? (version.startIndex ..< version.endIndex)]) == channelChar
        }
        return correct
    }

    func isValid() -> Bool {
        var valid: Bool = false
        UnityVersion.versionRegex.enumerateMatches(in: version, options: [], range: NSRange(0 ..< version.count)) { match, _, _ in
            guard let match = match else { return }
            valid = match.numberOfRanges == 6
        }
        return valid
    }

    static func validateEditor(path: String) -> Bool {
        do {
            var format = PropertyListSerialization.PropertyListFormat.xml
            let plistData = try Data(contentsOf: URL(fileURLWithPath: "\(path)/Unity.app/Contents/Info.plist"))
            if let plistDictionary = try PropertyListSerialization.propertyList(from: plistData, options: .mutableContainersAndLeaves, format: &format) as? [String: AnyObject] {
                if let bundleID = plistDictionary["CFBundleIdentifier"] as? String {
                    if !bundleID.contains("com.unity3d.UnityEditor") {
                        print("Invalid bundle identifier")
                        return false
                    }
                } else {
                    print("No bundle identifier")
                    return false
                }
            } else {
                print("No valid plist")
                return false
            }
        } catch {
            print(error.localizedDescription)
            return false
        }

        return true
    }
}

// MARK: - Modules

extension UnityVersion {
    func hasModule(module: UnityModule) -> Bool {
        return modules.contains(where: { $0.id == module.rawValue })
    }

    func getInstalledModules() -> [UnityModule] {
        var unityModules: [UnityModule] = []

        let modules: [ModuleJSON] = ModuleJSON.getModuleData(path)

        for module in modules {
            if module.selected, let unityModule = UnityModule(rawValue: module.id) {
                let index = unityModules.firstIndex(where: { $0.getPlatform() == unityModule.getPlatform() })
                if index == nil && unityModule != .none {
                    unityModules.append(unityModule)
                }
            }
        }

        return unityModules
    }
}

extension UnityVersion: Codable {}

extension UnityVersion: Comparable {
    func compare(other: UnityVersion) -> Int {
        if major == other.major {
            if minor == other.minor {
                if update == other.update {
                    if channel == other.channel {
                        if iteration == other.iteration {
                            return 0
                        }
                        return iteration > other.iteration ? 1 : -1
                    }
                    return channel > other.channel ? 1 : -1
                }
                return update > other.update ? 1 : -1
            }
            return minor > other.minor ? 1 : -1
        }
        return major > other.major ? 1 : -1
    }

    static func ==(lhs: UnityVersion, rhs: UnityVersion) -> Bool {
        return lhs.compare(other: rhs) == 0
    }

    static func <(lhs: UnityVersion, rhs: UnityVersion) -> Bool {
        return lhs.compare(other: rhs) == 1
    }

    static func >(lhs: UnityVersion, rhs: UnityVersion) -> Bool {
        return lhs.compare(other: rhs) == -1
    }
}

extension UnityVersion: Equatable {}

extension UnityVersion: Hashable {}

extension UnityVersion: Identifiable {
    var id: String {
        return version
    }
}
