import SwiftUI

struct SidebarLink<Label: View>: View {
	typealias LabelProvider = () -> Label

	private let item: SidebarItem
	private let label: LabelProvider

	init(item: SidebarItem, @ViewBuilder label: @escaping LabelProvider) {
		self.item = item
		self.label = label
	}

	var body: some View {
		NavigationLink(value: item, label: label)
	}
}

// MARK: - Init+

extension SidebarLink 
where Label == SwiftUI.Label<Text, Image>
{
	init(_ title: some StringProtocol, systemImage name: String, item: SidebarItem) {
		self.init(item: item, label: { Label(title, systemImage: name) })
	}

	init(_ titleKey: LocalizedStringKey, systemImage name: String, item: SidebarItem) {
		self.init(item: item, label: { Label(titleKey, systemImage: name) })
	}
}
