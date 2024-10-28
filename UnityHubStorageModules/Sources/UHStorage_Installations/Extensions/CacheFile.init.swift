import UHStorage_Common

public extension CacheFile where
	Model == InstallationCache
{
	/// Access the app's ``InstallationCache`` file.
	init(_ modelType: Model.Type = Model.self) {
		self.init(Model.$shared)
	}
}
