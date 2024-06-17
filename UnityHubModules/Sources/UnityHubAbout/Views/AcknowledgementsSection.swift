import SwiftUI

struct AcknowledgementsSection: View {
	var body: some View {
		VStack {
			Text("Powered By")
				.font(.headline)

			Link("Yams", destination: URL(string: "https://github.com/jpsim/Yams")!)
			Link("MoreWindows", destination: URL(string: "https://github.com/ryanslikesocool/MoreWindows")!)
			Link("SerializationKit", destination: URL(string: "https://github.com/ryanslikesocool/SerializationKit")!)
		}
	}
}
