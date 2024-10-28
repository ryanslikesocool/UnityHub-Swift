import SwiftUI

public extension Label where
	Title == Text,
	Icon == EmptyView
{
	init(_ title: some StringProtocol) {
		self.init(title: { Text(title) }, icon: EmptyView.init)
	}

	init(_ titleKey: LocalizedStringKey) {
		self.init(title: { Text(titleKey) }, icon: EmptyView.init)
	}
}
