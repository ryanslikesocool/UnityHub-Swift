import SwiftUI
import UnityHubStorage

public extension UnityEditorVersionLabel {
	struct Badge: View {
		private let text: String?
		private let color: Color

		public init(_ value: UnityEditorVersion) {
			if value.channel == .alpha {
				text = "Alpha"
				color = .red
			} else if value.channel == .beta {
				text = "Beta"
				color = .yellow
			} else if value.isLTS {
				text = "LTS"
				color = .gray
			} else {
				text = nil
				color = .clear
			}
		}

		public var body: some View {
			if let text {
				UnityHubCommonViews.Badge(text, color: color)
			}
		}
	}
}
