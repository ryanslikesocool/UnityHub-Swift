//
//  String.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/23/20.
//

import Foundation

extension String {
    mutating func trimPrefix(_ prefix: String) {
        if self.hasPrefix(prefix) {
            self = String(self.dropFirst(prefix.count))
        }
    }
}
