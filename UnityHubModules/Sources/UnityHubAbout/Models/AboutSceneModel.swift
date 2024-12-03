import Foundation
import OSLog

@MainActor
final class AboutSceneModel: ObservableObject {
	private(set) var acknowledgements: [Acknowledgement]

	init() {
		acknowledgements = []
	}
}

// MARK: -

extension AboutSceneModel {
	func loadAcknowledgements() {
		do {
			let result = try [Acknowledgement].load()

			objectWillChange.send()
			acknowledgements = result
		} catch {
			Logger.module.warning("""
			Failed to load acknowledgements:
			- Error: \(error)
			""")
		}
	}
}
