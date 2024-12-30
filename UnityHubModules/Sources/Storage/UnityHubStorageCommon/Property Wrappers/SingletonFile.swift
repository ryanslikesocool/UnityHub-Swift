import SwiftUI
import UnityHubCommon

@MainActor
@propertyWrapper
public struct SingletonFile<Model>: DynamicProperty where
	Model: SingletonFileProtocol
{
	@ObservedObject
	private var model: ObservingCurrentValue<Model>

	public var wrappedValue: Model {
		get { model.wrappedValue }
		nonmutating set {
			model.wrappedValue = newValue

			// TODO: instead of writing on every change, only write after a certain time interval or when entering background
			model.wrappedValue.write()
		}
	}

	public var projectedValue: Binding<Model> {
		Binding(
			get: { wrappedValue },
			set: { newValue in wrappedValue = newValue }
		)
	}

	public init(
		_ model: ObservingCurrentValue<Model>
	) {
		self.model = model
	}
}
