public extension TaskGroup {
	func reduce() async -> [ChildTaskResult] {
		await reduce(into: [ChildTaskResult]()) { result, element in
			result.append(element)
		}
	}
}
