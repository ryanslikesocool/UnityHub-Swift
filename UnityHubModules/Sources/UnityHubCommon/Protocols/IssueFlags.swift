public protocol IssueFlags: OptionSet, Hashable, CaseIterable where
	Self.Element == Self
{ }
