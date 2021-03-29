//
//  UnityVersionDecoder.swift
//  Unity Hub S
//
//  Created by RyanBoyer on 3/29/21.
//

import Foundation

struct UnityVersionDecoder: Codable {
    var version: String?
    var major: Int?
    var minor: Int?
    var update: Int?
    var channel: String?
    var iteration: Int?
    var installing: Bool?
    var lts: Bool?
    var path: String?
    
    func toUnityVersion() -> UnityVersion {
        var result = UnityVersion()
        
        result.version = version ?? "0.0.0a0"
        result.major = major ?? 0
        result.minor = minor ?? 0
        result.update = update ?? 0
        result.channel = channel ?? "a"
        result.iteration = iteration ?? 0
        result.installing = installing ?? false
        result.lts = lts ?? false
        result.path = path ?? #"/Applications/Unity/Hub/Editor/0.0.0a0"#
        
        return result
    }
}
