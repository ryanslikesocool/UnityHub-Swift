import UnityHubCommon

struct ProjectIssueFlags: IssueFlags {
	public typealias RawValue = UInt8

	public let rawValue: RawValue

	init(rawValue: RawValue) {
		self.rawValue = rawValue
	}
}

// MARK: - Sendable

extension ProjectIssueFlags: Sendable { }

// MARK: - Equatable

extension ProjectIssueFlags: Equatable { }

// MARK: - Hashable

extension ProjectIssueFlags: Hashable { }

// MARK: - CaseIterable

extension ProjectIssueFlags: CaseIterable {
	static let allCases: [Self] = [.missingProject, .missingInstallation]
}

// MARK: - Constants

extension ProjectIssueFlags {
	static let missingProject: Self = Self(rawValue: 1 << 0)
	static let missingInstallation: Self = Self(rawValue: 1 << 1)

	static let none: Self = Self(rawValue: 0)
}
