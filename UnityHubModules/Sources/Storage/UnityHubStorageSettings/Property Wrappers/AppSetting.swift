import SwiftUI
import UnityHubStorageCommon
import UnityHubCommon

public typealias AppSetting<Model, Value> = SingletonFileProperty<Model, Value> where Model: SettingsFileProtocol
