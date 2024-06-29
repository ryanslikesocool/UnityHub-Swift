import UnityHubCommonViews

struct ProjectIssueFlags: IssueFlags {
	let rawValue: UInt8

	init(rawValue: UInt8) {
		self.rawValue = rawValue
	}
}

// MARK: - CaseIterable

extension ProjectIssueFlags {
	static let allCases: [Self] = [.missingProject, .missingInstallation]
}

// MARK: - Constants

extension ProjectIssueFlags {
	static let missingProject: Self = Self(rawValue: 1 << 0)
	static let missingInstallation: Self = Self(rawValue: 1 << 1)

	static let none: Self = Self(rawValue: 0)
}
