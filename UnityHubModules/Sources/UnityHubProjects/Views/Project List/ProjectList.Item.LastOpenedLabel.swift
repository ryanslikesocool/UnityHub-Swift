import SwiftUI
import UnityHubCommon

extension ProjectList.Item {
	struct LastOpenedLabel: View {
		private let lastOpened: Date?

		init(date lastOpened: Date?) {
			self.lastOpened = lastOpened
		}

		var body: some View {
			Group {
				if let lastOpened {
					Text("\(Date.now.formatDistance(to: lastOpened)) ago")
						.help("Last opened on \(lastOpened.formatted(date: .abbreviated, time: .shortened))")
				} else {
					Text("Never opened")
				}
			}

			.foregroundStyle(.tertiary)
			.font(.caption)
		}
	}
}
