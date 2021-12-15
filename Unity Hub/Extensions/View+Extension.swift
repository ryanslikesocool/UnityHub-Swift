import Foundation
import Introspect
import SwiftUI

extension View {
	@ViewBuilder func scrollViewDisableMask() -> some View {
		introspectScrollView { scrollView in
			scrollView.contentView.layer?.masksToBounds = false
			scrollView.layer?.masksToBounds = false
			scrollView.superview?.layer?.masksToBounds = false
		}
	}

	@ViewBuilder func keyboardShortcutButton(_ shortcut: KeyboardShortcut, action: @escaping () -> Void) -> some View {
		background(
			Button(action: action) { EmptyView() }
				.keyboardShortcut(shortcut)
				.opacity(0)
				.frame(width: 0, height: 0)
				.allowsHitTesting(false)
		)
	}
}

extension View {
	@ViewBuilder func timer(_ duration: Double, repeating: Bool = false, action: @escaping (Timer) -> Void) -> some View {
		onAppear {
			Timer.delay(duration, repeating: repeating, action: action)
		}
	}

	@ViewBuilder func timer(_ duration: Double, repeating: Bool = false, action: @escaping () -> Void) -> some View {
		onAppear {
			Timer.delay(duration, repeating: repeating, action: action)
		}
	}
}
