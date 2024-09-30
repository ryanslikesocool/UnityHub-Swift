public extension AsyncSequence {
	func reduce() async throws -> [Self.Element] {
		try await reduce(into: [Element]()) { result, element in
			result.append(element)
		}
	}
}
