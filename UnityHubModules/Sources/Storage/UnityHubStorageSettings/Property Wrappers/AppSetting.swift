import SwiftUI
import UnityHubStorageCommon

public typealias AppSetting<Model, Value> = SingletonFileProperty<Model, Value> where
	Model: SettingsFileProtocol
