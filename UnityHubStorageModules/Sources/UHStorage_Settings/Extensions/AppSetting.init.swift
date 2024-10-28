public extension AppSetting where
	Model == GeneralSettings
{
	/// Access a property in the app's ``GeneralSettings`` file.
	init(general keyPath: any WritableKeyPath<Model, Value> & Sendable) {
		self.init(Model.$shared, keyPath)
	}
}

public extension AppSetting where
	Model == ProjectSettings
{
	/// Access a property in the app's ``ProjectSettings`` file.
	init(project keyPath: any WritableKeyPath<Model, Value> & Sendable) {
		self.init(Model.$shared, keyPath)
	}
}

public extension AppSetting where
	Model == InstallationSettings
{
	/// Access a property in the app's ``InstallationSettings`` file.
	init(installation keyPath: any WritableKeyPath<Model, Value> & Sendable) {
		self.init(Model.$shared, keyPath)
	}
}

public extension AppSetting where
	Model == LocationSettings
{
	/// Access a property in the app's ``LocationSettings`` file.
	init(location keyPath: any WritableKeyPath<Model, Value> & Sendable) {
		self.init(Model.$shared, keyPath)
	}
}
