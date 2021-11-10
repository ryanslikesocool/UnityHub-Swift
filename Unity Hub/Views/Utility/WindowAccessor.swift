import SwiftUI

struct WindowAccessor: NSViewRepresentable {
    @Binding var window: NSWindow?

    func makeNSView(context: Context) -> NSView {
        let view = NSView()
        Async.main {
            self.window = view.window
        }
        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {}
}

extension View {
    @ViewBuilder func windowAccess(binding: Binding<NSWindow?>, onAppear: ((NSWindow?) -> Void)? = nil) -> some View {
        background(
			WindowAccessor(window: binding)
				.onAppear {
					Async.main {
						if let onAppear = onAppear {
							onAppear(binding.wrappedValue)
						}
					}
				}
		)
    }
}
