import AppKit
import SerializationKit

public extension AppSettings {
	struct General: AppSettingsCategoryStorage {
		public static let category: AppSettingsCategory = .general

		public var appearance: AppAppearance { didSet { NSApp.appearance = appearance.nsAppearance } }
		public var dialogSuppression: DialogSuppression

		init() {
			appearance = .automatic
			dialogSuppression = .none
		}
	}
}

// MARK: - Codable

public extension AppSettings.General {
	private enum CodingKeys: CodingKey {
		case appearance
		case dialogSuppression
	}

	init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		self.init()

		appearance = try container.decodeIfPresent(forKey: .appearance) ?? appearance
		dialogSuppression = try container.decodeIfPresent(forKey: .dialogSuppression) ?? dialogSuppression

		// apply
		let appearance = self.appearance
		DispatchQueue.main.async {
			NSApp.appearance = appearance.nsAppearance
		}
	}

	func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(appearance, forKey: .appearance)
		try container.encode(dialogSuppression, forKey: .dialogSuppression)
	}
}
