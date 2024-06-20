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
