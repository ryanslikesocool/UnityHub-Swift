import SwiftUI
import UnityHubCommon
import UnityHubStorage

@MainActor
@propertyWrapper
public struct Cache<Model: CacheFile>: DynamicProperty {
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

	public init(_ model: ObservingCurrentValue<Model>) {
		self.model = model
	}
}

// MARK: - Convenience

public extension Cache where
	Model == ProjectCache
{
	init(_ modelType: Model.Type) {
		self.init(Model.$shared)
	}
}

public extension Cache where
	Model == InstallationCache
{
	init(_ modelType: Model.Type) {
		self.init(Model.$shared)
	}
}
