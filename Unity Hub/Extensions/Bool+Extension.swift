//
//  Bool+Extension.swift
//  Unity Hub S
//
//  Created by RyanBoyer on 7/3/21.
//

import Foundation

extension Bool {
	static var macOS12: Bool {
		guard #available(macOS 12, *) else {
			return true
		}
		return false
	}
}
