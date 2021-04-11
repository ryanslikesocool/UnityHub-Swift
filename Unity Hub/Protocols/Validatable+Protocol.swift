//
//  Validation+Protocol.swift
//  Unity Hub S
//
//  Created by RyanBoyer on 4/11/21.
//

import Foundation

protocol Validatable {
    mutating func validate() -> Bool
}
