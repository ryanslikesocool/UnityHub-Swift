import SwiftUI

extension SettingsView {
    struct Panel<Data, Content: View>: View {
        let title: String
        let symbol: String

        @Binding var data: Data
        @ViewBuilder let content: (Binding<Data>) -> Content

        var body: some View {
            VStack {
                content($data)
                Spacer()
            }
            .padding()
            .tabItem { Label(title, systemImage: symbol) }.tag(title)
        }
    }
}
