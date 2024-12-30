import SwiftUI
import UnityHubCommon

public typealias CacheFile<Model> = SingletonFile<Model> where Model: CacheFileProtocol