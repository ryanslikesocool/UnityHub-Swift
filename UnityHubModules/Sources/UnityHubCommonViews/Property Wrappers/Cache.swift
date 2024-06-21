import SwiftUI
import UnityHubCommon
import UnityHubStorage

@propertyWrapper
public struct Cache<Model: CacheFile>: DynamicProperty {
	@Bindable public var wrappedValue: Model = .shared

	public var projectedValue: Bindable<Model> { $wrappedValue }

	public init(_ modelType: Model.Type) { }
}
