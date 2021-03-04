//
//  UnityVersion.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/23/20.
//

import Foundation
import AppKit

struct UnityVersion {
    let version: String
    var major: Int
    var minor: Int
    var update: Int
    var channel: String
    var iteration: Int
    var installing: Bool
    
    var path: String = ""

    // a: alpha
    // b: beta
    // f: final (official)
    // p: patch
    // c: china
    static let versionRegex = try! NSRegularExpression(pattern: #"^(\d+)\.(\d+)\.(\d+)([a|b|f|p|c])(\d+)"#)
    static let null: UnityVersion = UnityVersion("0.0.0a0")

    init(_ version: String, path: String = "") {
        self.version = version
        self.major = 0
        self.minor = 0
        self.update = 0
        self.channel = ""
        self.iteration = 0
        self.installing = false
        
        self.path = path

        UnityVersion.versionRegex.enumerateMatches(in: version, options: [], range: NSRange(0 ..< version.count)) { (match, _, stop) in
            guard let match = match else { return }
            
            if match.numberOfRanges == 6,
               let range1 = Range(match.range(at: 1), in: version),
               let range2 = Range(match.range(at: 2), in: version),
               let range3 = Range(match.range(at: 3), in: version),
               let range4 = Range(match.range(at: 4), in: version),
               let range5 = Range(match.range(at: 5), in: version) {
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
    }

    func getBranch() -> String {
        return "\(major).\(minor)"
    }

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

    func isOfficial() -> Bool {
        return isCorrectChannel(version: version, channelChar: "f");
    }

    func isAlpha() -> Bool {
        return isCorrectChannel(version: version, channelChar: "a");
    }

    func isBeta() -> Bool {
        return isCorrectChannel(version: version, channelChar: "b");
    }
    
    func isPrerelease() -> Bool {
        return isAlpha() || isBeta()
    }

    func isCorrectChannel(version: String, channelChar: String) -> Bool {
        var correct: Bool = false
        UnityVersion.versionRegex.enumerateMatches(in: version, options: [], range: NSRange(0 ..< version.count)) { (match, _, stop) in
            guard let match = match else { return }
            correct = String(version[Range(match.range(at: 4), in: version) ?? (version.startIndex ..< version.endIndex)]) == channelChar
        }
        return correct
    }

    func isValid(version: String) -> Bool {
        var valid: Bool = false
        UnityVersion.versionRegex.enumerateMatches(in: version, options: [], range: NSRange(0 ..< version.count)) { (match, _, stop) in
            guard let match = match else { return }
            valid = match.numberOfRanges == 6
        }
        return valid
    }
}

extension UnityVersion: Comparable {
    static func ==(lhs: UnityVersion, rhs: UnityVersion) -> Bool {
        return lhs.compare(other: rhs) == 0
    }
    
    static func <(lhs: UnityVersion, rhs: UnityVersion) -> Bool {
        return lhs.compare(other: rhs) == 1
    }
    
    static func >(lhs: UnityVersion, rhs: UnityVersion) -> Bool {
        return lhs.compare(other: rhs) == 1
    }
}

extension UnityVersion: Equatable {}

extension UnityVersion: Hashable {}

extension UnityVersion: Identifiable {
    var id: String {
        return self.version
    }
}
