import SwiftUI

public extension Binding {
	/// Unwrap a binding to an optional value, providing a default value if the source value is `nil`.
	/// - Parameters:
	///   - optional: The binding to unwrap.
	///   - defaultValue: The default value to use if the source value is `nil`.
	@MainActor
	init(
		_ source: Binding<Value?>,
		default defaultValue: @autoclosure @escaping () -> Value
	) {
		self.init(
			get: { source.wrappedValue ?? defaultValue() },
			set: { newValue in
				source.wrappedValue = newValue
			}
		)
	}

	/// Unwrap a binding to an optional value, providing a fallback value if the source value is `nil`.
	///
	/// Unlike ``init(_:default:)``, if the unwrapped binding's value equals the fallback value, the optional binding's value will be set to `nil`.
	/// - Parameters:
	///   - optional: The binding to unwrap.
	///   - fallbackValue: The fallback value to use if the source value is `nil`.
	@MainActor
	init(
		_ source: Binding<Value?>,
		fallback fallbackValue: @autoclosure @escaping () -> Value
	) where
		Value: Equatable
	{
		self.init(
			get: { source.wrappedValue ?? fallbackValue() },
			set: { newValue in
				source.wrappedValue = if newValue == fallbackValue() {
					nil
				} else {
					newValue
				}
			}
		)
	}
}

public extension Binding<Bool> {
	/// Create a binding to a boolean value determining if an optional value is `nil`.
	/// - Parameter source: The binding to the nullable value.
	@MainActor
	init<Other>(
		notNil source: Binding<Other?>
	) {
		self.init(
			get: { source.wrappedValue != nil },
			set: { newValue in
				if !newValue {
					source.wrappedValue = nil
				}
			}
		)
	}

	/// Create a binding to a boolean value determining if an optional value is `nil`.
	/// - Parameters:
	///   - source: The binding to the nullable value.
	///   - fallbackValue: The value to fall back to when the new binding is set to `true`.
	@MainActor
	init<Other>(
		notNil source: Binding<Other?>,
		fallback fallbackValue: @autoclosure @escaping () -> Other
	) {
		self.init(
			get: { source.wrappedValue != nil },
			set: { newValue in
				source.wrappedValue = if newValue {
					fallbackValue()
				} else {
					nil
				}
			}
		)
	}

	/// Create a binding to a boolean value determining if an optional value is `nil`.
	/// - Parameter source: The binding to the nullable value.
	@MainActor
	init<Other>(
		notNil source: State<Other?>
	) {
		self.init(
			get: { source.wrappedValue != nil },
			set: { newValue in
				if !newValue {
					source.wrappedValue = nil
				}
			}
		)
	}

	/// Create a binding to a boolean value determining if an optional value is `nil`.
	/// - Parameters:
	///   - source: The binding to the nullable value.
	///   - fallbackValue: The value to fall back to when the new binding is set to `true`.
	@MainActor
	init<Other>(
		notNil source: State<Other?>,
		fallback fallbackValue: @autoclosure @escaping () -> Other
	) {
		self.init(
			get: { source.wrappedValue != nil },
			set: { newValue in
				source.wrappedValue = if !newValue {
					nil
				} else {
					fallbackValue()
				}
			}
		)
	}

	/// Create a binding to a boolean value determining if a binding equals the given value.
	/// - Parameters:
	///   - source: The binding to the compared value.
	///   - equalityValue: The value to match.
	@MainActor
	init<Other>(
		_ source: Binding<Other>,
		equals equalityValue: @autoclosure @escaping () -> Other
	) where
		Other: Equatable
	{
		self.init(
			get: { source.wrappedValue == equalityValue() },
			set: { newValue in
				if newValue {
					source.wrappedValue = equalityValue()
				}
			}
		)
	}

	/// Create a binding to a boolean value determining if a binding equals the given value.
	/// - Parameters:
	///   - source: The binding to the compared value.
	///   - equalityValue: The value to match.
	///   - fallbackValue: The value to fall back to when the new binding is set to `false`.
	@MainActor
	init<Other>(
		_ source: Binding<Other>,
		equals equalityValue: @autoclosure @escaping () -> Other,
		fallback fallbackValue: @autoclosure @escaping () -> Other
	) where
		Other: Equatable
	{
		self.init(
			get: { source.wrappedValue == equalityValue() },
			set: { newValue in
				source.wrappedValue = if newValue {
					equalityValue()
				} else {
					fallbackValue()
				}
			}
		)
	}
}
