import SwiftUI

struct AcknowledgementsButton: View {
	public init() { }

	public var body: some View {
		Button(
			String(localized: .acknowledgements.item.dependencies),
			systemImage: .book_closed
		) {
			fatalError("\(Self.self).\(#function) is not implemented")
		}
	}
}
