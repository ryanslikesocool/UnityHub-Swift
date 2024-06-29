import SwiftUI

extension DownloadSheet {
	struct PageView: View {
		private let page: DownloadSheetPage

		init(_ page: DownloadSheetPage) {
			self.page = page
		}

		var body: some View {
			Form {
				Text(String(describing: page))
			}
			.formStyle(.grouped)
		}
	}
}
