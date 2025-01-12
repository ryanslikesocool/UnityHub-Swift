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
	nonisolated func loadCredit<C>(_ type: C.Type) async where
		C: CreditProtocol
	{
		do {
			guard let url = Bundle.main.url(forResource: C.fileName, withExtension: C.fileExtension) else {
				throw CocoaError(.fileReadNoSuchFile)
			}
			let data = try Data(contentsOf: url)

			var credits = try C.topLevelDecoder.decode([C].self, from: data)
			if let sortComparator = C.sortComparator {
				credits.sort(using: sortComparator)
			}

			await MainActor.run {
				objectWillChange.send()
				self[keyPath: C.modelKeyPath] = credits
			}
		} catch {
			assertionFailure("""
			Failed to load credit file:
			- Error: \(error)
			- Type: \(C.self)
			- File Name: \(C.fileName).\(C.fileExtension)
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
