import SwiftUI

public extension Binding<Bool> {
	init<T>(nonNil: Binding<T?>) {
		self.init(
			get: { nonNil.wrappedValue != nil },
			set: { newValue in
				if !newValue {
					nonNil.wrappedValue = nil
				}
			}
		)
	}
}
