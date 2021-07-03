//
//  SwipeActions.swift
//  Unity Hub S
//
//  Created by RyanBoyer on 7/3/21.
//

import Foundation
import SwiftUI

extension View {
	@ViewBuilder public func `if`<Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content) -> some View {
		if condition() {
			AnyView(transform(self))
		} else {
			AnyView(self)
		}
	}
}
