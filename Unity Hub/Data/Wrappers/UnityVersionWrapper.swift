//
//  UnityVersionDecoder.swift
//  Unity Hub S
//
//  Created by RyanBoyer on 3/29/21.
//

import Foundation

struct UnityVersionWrapper: Codable {
    var version: String?
    var path: String?

    init(original: UnityVersion) {
        version = original.version
        path = original.path
    }

    func unwrap() -> UnityVersion {
        return UnityVersion(version ?? "0.0.0a0", path: path ?? #"/Applications/Unity/Hub/Editor/0.0.0a0"#)
    }

    static func wrap(_ originals: [UnityVersion]?) -> [UnityVersionWrapper]? {
        if let originals = originals {
            var result: [UnityVersionWrapper] = []
            for data in originals {
                result.append(UnityVersionWrapper(original: data))
            }
            return result
        }
        return nil
    }
}
