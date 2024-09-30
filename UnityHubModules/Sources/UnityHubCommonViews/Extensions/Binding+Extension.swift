import SwiftUI

extension Binding where
	Value: Equatable
{
	@MainActor
	init(_ original: Binding<Value?>, defaultValue: Value) {
		self.init(
			get: { original.wrappedValue ?? defaultValue },
			set: { newValue in
				original.wrappedValue = if newValue == defaultValue {
					nil
				} else {
					newValue
				}
			}
		)
	}
}
