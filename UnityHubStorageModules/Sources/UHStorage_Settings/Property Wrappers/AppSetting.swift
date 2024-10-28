import SwiftUI
import UHStorage_Common
import UnityHubCommon

public typealias AppSetting<Model, Value> = SingletonFileProperty<Model, Value> where Model: SettingsFileProtocol