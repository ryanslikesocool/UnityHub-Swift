import SwiftUI

struct ContributorsButton: View {
	public init() { }

	public var body: some View {
		Button(
			String(localized: .credits.group.contributors),
			systemImage: .person_3
		) {
			fatalError("\(Self.self).\(#function) is not implemented")
		}
	}
}
