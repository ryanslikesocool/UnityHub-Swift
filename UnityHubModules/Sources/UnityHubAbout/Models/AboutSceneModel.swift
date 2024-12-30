import Foundation
import OSLog

@MainActor
final class AboutSceneModel: ObservableObject {
	/* private(set) */ var dependencies: [Dependency]
	/* private(set) */ var contributors: [Contributor]

	init() {
		dependencies = []
		contributors = []
	}
}

// MARK: -

extension AboutSceneModel {
	nonisolated func loadAcknowledgement<A>(_ type: A.Type) async where
		A: Acknowledgement
	{
		do {
			guard let url = Bundle.main.url(forResource: A.fileName, withExtension: A.fileExtension) else {
				throw CocoaError(.fileReadNoSuchFile)
			}
			let data = try Data(contentsOf: url)

			var acknowledgements = try A.decoder.decode([A].self, from: data)
			if let sortComparator = A.sortComparator {
				acknowledgements.sort(using: sortComparator)
			}

			await MainActor.run {
				objectWillChange.send()
				self[keyPath: A.modelKeyPath] = acknowledgements
			}
		} catch {
			assertionFailure("""
			Failed to load acknowledgement file:
			- Error: \(error)
			- Type: \(A.self)
			- File Name: \(A.fileName).\(A.fileExtension)
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
