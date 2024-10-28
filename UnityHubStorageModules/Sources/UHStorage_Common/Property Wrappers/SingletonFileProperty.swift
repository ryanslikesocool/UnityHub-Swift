import SwiftUI
import UnityHubCommon

@MainActor
@propertyWrapper
public struct SingletonFileProperty<Model, Value>: DynamicProperty where
	Model: SingletonFileProtocol
{
	@SingletonFile private var model: Model

	private let keyPath: any WritableKeyPath<Model, Value> & Sendable

	public var wrappedValue: Value {
		get { model[keyPath: keyPath] }
		nonmutating set { model[keyPath: keyPath] = newValue }
	}

	public var projectedValue: Binding<Value> {
		Binding(
			get: { wrappedValue },
			set: { newValue in wrappedValue = newValue }
		)
	}

	public init(
		_ model: ObservingCurrentValue<Model>,
		_ keyPath: any WritableKeyPath<Model, Value> & Sendable
	) {
		_model = SingletonFile(model)
		self.keyPath = keyPath
	}
}
