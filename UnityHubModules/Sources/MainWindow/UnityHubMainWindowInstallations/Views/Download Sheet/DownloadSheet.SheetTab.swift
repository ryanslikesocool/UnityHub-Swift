import SwiftUI

extension DownloadSheet {
	struct SheetTab: View {
		private let tab: DownloadSheetTab

		init(_ tab: DownloadSheetTab) {
			self.tab = tab
		}

		var body: some View {
			Form {
				Text(String(describing: tab))
			}
			.formStyle(.grouped)
		}
	}
}
