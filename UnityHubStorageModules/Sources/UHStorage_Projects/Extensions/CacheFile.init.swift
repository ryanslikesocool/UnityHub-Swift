import UHStorage_Common

public extension CacheFile where
	Model == ProjectCache
{
	/// Access the app's ``ProjectCache`` file.
	init(_ modelType: Model.Type = Model.self) {
		self.init(Model.$shared)
	}
}