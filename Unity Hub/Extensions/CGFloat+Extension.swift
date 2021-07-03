//
//  CGFloat+Extension.swift
//  Unity Hub S
//
//  Created by RyanBoyer on 3/28/21.
//

import Foundation

extension CGFloat {
	static var swipeActionLargeIconSize: CGFloat { return 32 }
	static var swipeActionSmallIconSize: CGFloat { return 16 }

	static var listItemHeight: CGFloat { return 48 }
	static var smallListItemHeight: CGFloat { return 24 }

	static var swipeActionButtonWidth: CGFloat { return 64 }

	static func lerp(_ from: CGFloat, _ to: CGFloat, _ rel: CGFloat) -> CGFloat {
		return ((1 - rel) * from) + (rel * to)
	}
}
