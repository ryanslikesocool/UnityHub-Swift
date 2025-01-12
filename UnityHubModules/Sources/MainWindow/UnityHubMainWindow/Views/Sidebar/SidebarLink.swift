import SwiftUI
import UnityHubCommonViews

struct SidebarLink<Label>: View where
	Label: View
{
	private let item: SidebarItem
	private let label: Label

	public init(
		item: SidebarItem,
		@ViewBuilder label: () -> Label
	) {
		self.item = item
		self.label = label()
	}

	public var body: some View {
		NavigationLink(value: item) {
			label
		}
	}
}

// MARK: - Convenience

extension SidebarLink
	where Label == SwiftUI.Label<Text, Image>
{
	init(_ item: SidebarItem) {
		self.init(item: item) {
			Label(
				item.localizedStringResource,
				systemImage: item.systemImage.rawValue
			)
		}
	}

//	init(
//		_ title: some StringProtocol,
//		systemImage name: String,
//		item: SidebarItem
//	) {
//		self.init(item: item, label: { Label(title, systemImage: name) })
//	}
//
//	init(
//		_ titleKey: LocalizedStringKey,
//		systemImage name: String,
//		item: SidebarItem
//	) {
//		self.init(item: item, label: { Label(titleKey, systemImage: name) })
//	}
}
