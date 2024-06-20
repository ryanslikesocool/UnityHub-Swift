import OSLog
import UnityHubCommon

extension Logger {
	@usableFromInline static let module: Logger = Logger(subsystem: Self.unityHubSubmodule, category: "UnityHubCommonViews")
}
