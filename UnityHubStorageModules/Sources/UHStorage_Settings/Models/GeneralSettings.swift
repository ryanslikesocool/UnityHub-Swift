import Foundation
import UnityHubCommon

@Observable
public final class GeneralSettings {
	public var appearance: Appearance { didSet { save() } }
	public var dialogSuppression: DialogSuppression { didSet { save() } }
	public var backgroundMode: BackgroundMode { didSet { save() } }
	public var sidebarDisplay: SidebarDisplay { didSet { save() } }

	public init() {
		appearance = .automatic
		dialogSuppression = .none
		backgroundMode = .hide
		sidebarDisplay = .standard
	}
}

// MARK: - Hashable

public extension GeneralSettings {
	func hash(into hasher: inout Hasher) {
		hasher.combine(appearance)
		hasher.combine(dialogSuppression)
		hasher.combine(backgroundMode)
		hasher.combine(sidebarDisplay)
	}
}

// MARK: - Codable

/// - NOTE: use manual `Codable` implementation since values may change in the future.

public extension GeneralSettings {
	private enum CodingKeys: CodingKey {
		case appearance
		case dialogSuppression
		case backgroundMode
		case sidebarDisplay
	}

	convenience init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		self.init()

		/// - NOTE: use `decodeIfPresent` to avoid issues when adding new settings

		appearance = try container.decodeIfPresent(forKey: .appearance) ?? appearance
		dialogSuppression = try container.decodeIfPresent(forKey: .dialogSuppression) ?? dialogSuppression
		backgroundMode = try container.decodeIfPresent(forKey: .backgroundMode) ?? backgroundMode
		sidebarDisplay = try container.decodeIfPresent(forKey: .sidebarDisplay) ?? sidebarDisplay
	}

	func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(appearance, forKey: .appearance)
		try container.encode(dialogSuppression, forKey: .dialogSuppression)
		try container.encode(backgroundMode, forKey: .backgroundMode)
		try container.encode(sidebarDisplay, forKey: .sidebarDisplay)
	}
}

// MARK: - SettingsFile

extension GeneralSettings: SettingsFile {
	public static let shared: GeneralSettings = GeneralSettings.load()

	public static let category: SettingsCategory = .general
}
