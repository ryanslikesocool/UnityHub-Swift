import SwiftUI

struct Toolbar<Content: ToolbarContent>: View {
    let content: () -> Content

    init(@ToolbarContentBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        Color.clear
            .frame(width: 0, height: 0)
            .toolbar {
                content()
            }
    }
}
