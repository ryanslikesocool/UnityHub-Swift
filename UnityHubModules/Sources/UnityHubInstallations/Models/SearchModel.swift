import UnityHubStorage

struct SearchModel {
	public var query: String
	public var tokens: [SearchToken]

	init() {
		query = ""
		tokens = []
	}
}

// MARK: - Sendable

extension SearchModel: Sendable { }

// MARK: - Equatable

extension SearchModel: Equatable { }

// MARK: - Hashable

extension SearchModel: Hashable { }

// MARK: -

extension SearchModel {
	func filterFunction(installations: [InstallationMetadata]) -> [InstallationMetadata] {
		var result: [InstallationMetadata] = installations

		if !query.isEmpty {
			result = result.filter { installation in
				(try? installation.version)?.description.localizedStandardContains(query) == true
			}
		}

		for token in tokens {
			result = switch token {
				case let .lts(state): result.filter { (try? $0.version)?.isLTS == state }
				case let .prerelease(state): result.filter { (try? $0.version)?.isPrerelease == state }
				case let .majorVersion(value): result.filter { (try? $0.version)?.major == value }
			}
		}

		return result
	}
}