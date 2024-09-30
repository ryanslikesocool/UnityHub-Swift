import SwiftUI
import UnityHubCommon
import UnityHubStorage

@propertyWrapper
public struct AppSetting<Model: SettingsFile, Value>: DynamicProperty {
	@Bindable private var model: Model = .shared
	private let keyPath: ReferenceWritableKeyPath<Model, Value>

	public var wrappedValue: Value {
		get { model[keyPath: keyPath] }
		nonmutating set {
			model[keyPath: keyPath] = newValue

			// TODO: instead of writing on every change, only write after a certain time interval or when entering background
			model.save()
		}
	}

	@MainActor
	public var projectedValue: Binding<Value> {
		Binding(
			get: { wrappedValue },
			set: { wrappedValue = $0 }
		)
	}

	public init(_ model: Model.Type, _ keyPath: ReferenceWritableKeyPath<Model, Value>) {
		self.keyPath = keyPath
	}
}

// MARK: - General Settings

public extension AppSetting where
	Model == GeneralSettings
{
	init(general keyPath: ReferenceWritableKeyPath<Model, Value>) {
		self.init(Model.self, keyPath)
	}
}

// MARK: - Project Settings

public extension AppSetting where
	Model == ProjectSettings
{
	init(project keyPath: ReferenceWritableKeyPath<Model, Value>) {
		self.init(Model.self, keyPath)
	}
}

// MARK: - Installation Settings

public extension AppSetting where
	Model == InstallationSettings
{
	init(installation keyPath: ReferenceWritableKeyPath<Model, Value>) {
		self.init(Model.self, keyPath)
	}
}

// MARK: - Location Settings

public extension AppSetting where
	Model == LocationSettings
{
	init(location keyPath: ReferenceWritableKeyPath<Model, Value>) {
		self.init(Model.self, keyPath)
	}
}
