import SwiftUI

struct AcknowledgementsSection: View {
	var body: some View {
		VStack(spacing: 0) {
			Text("Powered By")
				.font(.headline)

			Link("MoreWindows", destination: URL(string: "https://github.com/ryanslikesocool/MoreWindows")!)
			Link("SerializationKit", destination: URL(string: "https://github.com/ryanslikesocool/SerializationKit")!)
		}
	}
}
