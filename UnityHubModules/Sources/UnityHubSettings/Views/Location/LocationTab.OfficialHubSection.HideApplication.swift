import OSLog
import SwiftUI
import UnityHubCommon
import UnityHubCommonViews

extension LocationTab.OfficialHubSection {
	struct HideApplicationToggle: View {
		@Binding private var isOn: Bool

		init(applicationURL: URL) {
			_isOn = Binding(
				get: { (try? Utility.Application.getLSUIElement(from: applicationURL)) ?? false },
				set: { _ in print("\(Self.self).\(#function) is not implemented") }
			)
		}

		var body: some View {
			Toggle("Hide In Dock", isOn: $isOn)
		}
	}
}
