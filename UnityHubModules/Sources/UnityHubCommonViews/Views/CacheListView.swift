import OSLog
import SwiftUI
import UnityHubCommon

public struct CacheListView<Item: Identifiable, ItemView: View, NoItemsView: View>: View {
	public typealias ItemProvider = (Binding<Item>) -> ItemView
	public typealias NoItemsProvider = () -> NoItemsView
	public typealias ItemFilter = ([Item]) -> [Item]

	private let itemView: ItemProvider
	private let noItemsView: NoItemsProvider

	@Binding private var items: [Item]
	private let itemFilter: ItemFilter

	private var filteredItems: [Item] {
		itemFilter(items)
	}

	private var isEmpty: Bool { items.isEmpty }

	public init(
		items: Binding<[Item]>,
		itemFilter: @escaping ItemFilter,
		@ViewBuilder item itemView: @escaping ItemProvider,
		@ViewBuilder noItems noItemsView: @escaping NoItemsProvider
	) {
		_items = items
		self.itemFilter = itemFilter
		self.itemView = itemView
		self.noItemsView = noItemsView
	}

	public var body: some View {
		lazy var filteredItems: [Item] = self.filteredItems

		Group {
			if items.isEmpty {
				noItemsView()
			} else if filteredItems.isEmpty {
				noSearchResultsView()
			} else {
				listView()
			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
	}
}

// MARK: - Supporting Views

private extension CacheListView {
	func noSearchResultsView() -> some View {
		Label("No Search Results", systemImage: Constant.Symbol.magnifyingGlass)
			.labelStyle(.large)
	}

	func listView() -> some View {
		List(filteredItems) { item in
			let binding = Binding<Item>(
				get: { item },
				set: { newValue in
					guard let index = items.firstIndex(where: { $0.id == newValue.id }) else {
//						Logger.module.warning("Missing item with ID \(newValue.id)")
						// TODO: figure out why log breaks compilation
						return
					}
					items[index] = newValue
				}
			)

			itemView(binding)
		}
	}
}
