import Foundation
import UnityHubCommonViews

enum InstallationsModelState {
	case `default`

	case downloadInstallation
	case locateInstallation(LocateEventCompletion)
	case removeInstallation(URL)
	case missingInstallation(URL)
}

// MARK: - Sendable

extension InstallationsModelState: Sendable { }

// MARK: - Equatable

extension InstallationsModelState: Equatable { }

// MARK: - Hashable

extension InstallationsModelState: Hashable { }

// MARK: -

extension InstallationsModelState {
	var locateInstallationCompletion: LocateEventCompletion? {
		get {
			if case let .locateInstallation(completion) = self {
				completion
			} else {
				nil
			}
		}
		set {
			self = if let newValue {
				.locateInstallation(newValue)
			} else {
				.default
			}
		}
	}

	var removeInstallationURL: URL? {
		get {
			if case let .removeInstallation(url) = self {
				url
			} else {
				nil
			}
		}
		set {
			self = if let newValue {
				.removeInstallation(newValue)
			} else {
				.default
			}
		}
	}

	var missingInstallationURL: URL? {
		get {
			if case let .missingInstallation(url) = self {
				url
			} else {
				nil
			}
		}
		set {
			self = if let newValue {
				.missingInstallation(newValue)
			} else {
				.default
			}
		}
	}
}