public extension OptionSet {
	subscript(element: Self.Element) -> Bool {
		get { contains(element) }
		set {
			if newValue {
				insert(element)
			} else {
				remove(element)
			}
		}
	}
}

public extension OptionSet where Self: CaseIterable, Self.Element == Self {
	var isEmpty: Bool {
		enumerated.isEmpty
	}

	var count: Int {
		enumerated.count
	}

	var enumerated: [Element] {
		Self.allCases.filter(contains)
	}
}
