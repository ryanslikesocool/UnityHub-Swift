import MoreWindows
import SwiftUI

struct CopyrightSection: View {
	var body: some View {
		VStack {
			Section {
				Text("Unity Hub (Swift) © 2021 Ryan Boyer")
				Text("Unity, Unity Hub © Unity Technologies Inc.")
			}
			.font(.caption)
			.foregroundStyle(.secondary)
		}
	}
}
