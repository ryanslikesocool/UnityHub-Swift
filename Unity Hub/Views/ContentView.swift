import SwiftUI

struct ContentView: View {
	
    var body: some View {
		Text("Hub")
    }

    func toggleSidebar() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
}
