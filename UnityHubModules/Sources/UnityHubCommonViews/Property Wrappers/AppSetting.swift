import SwiftUI
import UnityHubCommon
import UnityHubStorage

@MainActor
@propertyWrapper
public struct AppSetting<Model: SettingsFile, Value>: DynamicProperty {
	@ObservedObject
	private var model: ObservingCurrentValue<Model>

	private let keyPath: any WritableKeyPath<Model, Value> & Sendable

	public var wrappedValue: Value {
		get { model.wrappedValue[keyPath: keyPath] }
		nonmutating set {
			model.wrappedValue[keyPath: keyPath] = newValue

			// TODO: instead of writing on every change, only write after a certain time interval or when entering background
			model.wrappedValue.write()
		}
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
		self.model = model
		self.keyPath = keyPath
	}
}

// MARK: - General Settings

public extension AppSetting where
	Model == GeneralSettings
{
	init(general keyPath: any WritableKeyPath<Model, Value> & Sendable) {
		self.init(Model.$shared, keyPath)
	}
}

// MARK: - Project Settings

public extension AppSetting where
	Model == ProjectSettings
{
	init(project keyPath: any WritableKeyPath<Model, Value> & Sendable) {
		self.init(Model.$shared, keyPath)
	}
}

// MARK: - Installation Settings

public extension AppSetting where
	Model == InstallationSettings
{
	init(installation keyPath: any WritableKeyPath<Model, Value> & Sendable) {
		self.init(Model.$shared, keyPath)
	}
}

// MARK: - Location Settings

public extension AppSetting where
	Model == LocationSettings
{
	init(location keyPath: any WritableKeyPath<Model, Value> & Sendable) {
		self.init(Model.$shared, keyPath)
	}
}
