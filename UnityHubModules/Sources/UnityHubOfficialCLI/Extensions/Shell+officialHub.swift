import Foundation
import OSLog
import UnityHubCommon
import UnityHubStorage

public extension Shell {
	@usableFromInline internal static var officialHubExecutable: URL {
		get throws {
			try Utility.Application.getBundleExecutable(from: LocationSettings.shared.officialHubLocation ?? Constant.Settings.Location.defaultOfficialHubLocation)
		}
	}

	@inlinable @discardableResult static func officialHub(_ arguments: some Sequence<String>) throws -> String {
		try execute(officialHubExecutable, arguments: ["--", "--headless"] + arguments)
	}

	@inlinable @discardableResult static func officialHub(_ arguments: String...) throws -> String {
		try officialHub(arguments)
	}
}
