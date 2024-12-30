import SwiftUI

struct AnySidebarStyle: SidebarStyle {
	private let _makeBody: @MainActor (Configuration) -> AnyView

	init(_ style: some SidebarStyle) {
		_makeBody = if let style = style as? Self {
			style._makeBody
		} else {
			{ @MainActor configuration in
				AnyView(style.makeBody(configuration: configuration))
			}
		}
	}

	public func makeBody(configuration: Configuration) -> some View {
		_makeBody(configuration)
	}
}
