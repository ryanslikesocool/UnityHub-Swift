import Foundation
import OSLog

@MainActor
final class AboutSceneModel: ObservableObject {
	/* private(set) */ var acknowledgements: [Acknowledgement]
	/* private(set) */ var contributors: [Contributor]

	init() {
		acknowledgements = []
		contributors = []
	}
}

// MARK: -

extension AboutSceneModel {
	nonisolated func loadCredits<Item>(
		ofType type: Item.Type
	) async where
		Item: CreditItem
	{
		do {
			guard let url = Item.fileURL else {
				throw CocoaError(.fileReadNoSuchFile)
			}
			let data = try Data(contentsOf: url)

			var credits = try Item.topLevelDecoder.decode([Item].self, from: data)
			if let sortComparator = Item.sortComparator {
				credits.sort(using: sortComparator)
			}

			await MainActor.run {
				objectWillChange.send()
				self[keyPath: Item.modelKeyPath] = credits
			}
		} catch {
			assertionFailure("""
			Failed to load credit file:
			- Type: \(Item.self)
			- Error: \(error)
			""")
		}
	}

//	nonisolated func loadDependencies() async {
//		await loadAcknowledgement(Dependency.self)
//	}
//
//	nonisolated func loadContributors() async {
//		await loadAcknowledgement(Contributor.self)
//	}
}
