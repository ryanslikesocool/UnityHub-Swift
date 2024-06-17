public protocol AppSettingsCategoryStorage: Hashable, Codable {
	static var category: AppSettingsCategory { get }
}
