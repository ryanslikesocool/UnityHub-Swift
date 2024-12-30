import SwiftUI

extension ProjectList {
	struct ProjectPinnedToggle: View {
		@Binding private var isOn: Bool

		public init(isOn: Binding<Bool>) {
			_isOn = isOn
		}

		public var body: some View {
			Toggle(isOn: $isOn, label: Label.pin)
		}
	}
}