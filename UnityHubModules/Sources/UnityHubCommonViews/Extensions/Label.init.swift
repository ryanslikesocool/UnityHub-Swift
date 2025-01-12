import SwiftUI

public extension Label where
	Title == Text,
	Icon == EmptyView
{
	nonisolated init<S>(
		_ title: S
	) where
		S: StringProtocol
	{
		self.init(title: { Text(title) }, icon: EmptyView.init)
	}

	nonisolated init(
		_ titleKey: LocalizedStringKey
	) {
		self.init(title: { Text(titleKey) }, icon: EmptyView.init)
	}
}
