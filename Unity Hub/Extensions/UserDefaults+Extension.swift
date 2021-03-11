//
//  UserDefaults+Extension.swift
//  Unity Hub S
//
//  Created by RyanBoyer on 3/10/21.
//

import Foundation

extension UserDefaults {
    static func hasKey(_ key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}
