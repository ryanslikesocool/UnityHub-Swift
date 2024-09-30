import UnityHubCommonViews

struct InstallationIssueFlags: IssueFlags {
	let rawValue: UInt8

	init(rawValue: UInt8) {
		self.rawValue = rawValue
	}
}

// MARK: - Sendable

extension InstallationIssueFlags: Sendable { }

// MARK: - Equatable

extension InstallationIssueFlags: Equatable { }

// MARK: - Hashable

extension InstallationIssueFlags: Hashable { }

// MARK: - CaseIterable

extension InstallationIssueFlags {
	static let allCases: [Self] = [.missingInstallation]
}

// MARK: - Constants

extension InstallationIssueFlags {
	static let missingInstallation: Self = Self(rawValue: 1 << 0)

	static let none: Self = Self(rawValue: 0)
}
