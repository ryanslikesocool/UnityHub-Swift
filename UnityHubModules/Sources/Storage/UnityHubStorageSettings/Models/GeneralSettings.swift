import Combine
import Foundation
import UnityHubStorageCommon
import UnityHubCommon

public struct GeneralSettings {
	public var appearance: Appearance
	public var dialogSuppression: DialogSuppression
	public var backgroundMode: BackgroundMode
	public var sidebarDisplay: SidebarDisplay

	public init() {
		appearance = .automatic
		dialogSuppression = .none
		backgroundMode = .hide
		sidebarDisplay = .standard
	}
}

// MARK: - Sendable

extension GeneralSettings: Sendable { }

// MARK: - Equatable

extension GeneralSettings: Equatable { }

// MARK: - Hashable

extension GeneralSettings: Hashable { }

// MARK: - Codable

/// - NOTE: use manual `Codable` implementation since values may change in the future.

extension GeneralSettings: Codable {
	private enum CodingKeys: CodingKey {
		case appearance
		case dialogSuppression
		case backgroundMode
		case sidebarDisplay
	}

	public init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		self.init()

		/// - NOTE: use `decodeIfPresent` to avoid issues when adding new settings

		appearance = try container.decodeIfPresent(forKey: .appearance) ?? appearance
		dialogSuppression = try container.decodeIfPresent(forKey: .dialogSuppression) ?? dialogSuppression
		backgroundMode = try container.decodeIfPresent(forKey: .backgroundMode) ?? backgroundMode
		sidebarDisplay = try container.decodeIfPresent(forKey: .sidebarDisplay) ?? sidebarDisplay
	}

	public func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(appearance, forKey: .appearance)
		try container.encode(dialogSuppression, forKey: .dialogSuppression)
		try container.encode(backgroundMode, forKey: .backgroundMode)
		try container.encode(sidebarDisplay, forKey: .sidebarDisplay)
	}
}

// MARK: - SingletonFileProtocol

extension GeneralSettings: SingletonFileProtocol {
	@ObservingCurrentValue
	public static var shared: Self = Self.read(sharedSubscriber) {
		didSet {
			shared.write()
		}
	}

	@MainActor
	static let sharedSubscriber: AnyCancellable = $shared.publisher
		.sink { newValue in newValue.write() }

	public func initialize() {
		appearance.apply()
	}
}

// MARK: - SettingsFileProtocol

extension GeneralSettings: SettingsFileProtocol {
	public static let category: SettingsCategory = .general
}
