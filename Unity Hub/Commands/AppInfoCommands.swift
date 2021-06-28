//
//  AboutAppView.swift
//  Unity Hub S
//
//  Created by RyanBoyer on 6/28/21.
//

import SwiftUI

struct AppInfoCommands: Commands {
	@CommandsBuilder var body: some Commands {
		CommandGroup(replacing: .appInfo) {
			Button("About Unity Hub S") {
				NSApplication.shared.orderFrontStandardAboutPanel(
					options: [
						NSApplication.AboutPanelOptionKey.credits: NSAttributedString(
							string: "Made with ❤️ by Ryan Boyer.",
							attributes: [
								NSAttributedString.Key.font: NSFont.boldSystemFont(
									ofSize: NSFont.smallSystemFontSize)
							]
						),
						NSApplication.AboutPanelOptionKey(rawValue: "Copyright"): "© 2021 RYAN BOYER"
					]
				)
			}
		}
	}
}
