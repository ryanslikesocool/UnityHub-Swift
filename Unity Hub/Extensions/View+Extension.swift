import Foundation
import Introspect
import SwiftUI

extension View {
    @ViewBuilder public func `if`<Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content) -> some View {
        if condition() {
            AnyView(transform(self))
        } else {
            AnyView(self)
        }
    }

    @ViewBuilder func scrollViewDisableMask() -> some View {
        return introspectScrollView { scrollView in
            scrollView.contentView.layer?.masksToBounds = false
            scrollView.layer?.masksToBounds = false
            scrollView.superview?.layer?.masksToBounds = false
        }
    }

    @ViewBuilder func keyboardShortcutButton(_ shortcut: KeyboardShortcut, action: @escaping () -> Void) -> some View {
        background(
            Button(action: action) { Text("???") }
                .keyboardShortcut(shortcut)
                .opacity(0)
                .frame(width: 0, height: 0)
        )
    }
}
