//
//  String.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/23/20.
//

import Foundation

extension String {
    static var pinIcon: String { return "pin.fill" }
    static var trashIcon: String { return "trash.fill" }
    static var warningIcon: String { return "exclamationmark.triangle.fill" }

    mutating func trimPrefix(_ prefix: String) {
        if self.hasPrefix(prefix) {
            self = String(self.dropFirst(prefix.count))
        }
    }
}
