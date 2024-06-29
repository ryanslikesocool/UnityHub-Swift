import SwiftUI
import UnityHubCommon
import UnityHubCommonViews

struct DownloadSheet: View {
	@Environment(\.dismiss) private var dismiss

	var body: some View {
		Sheet {
			NavigationStack {
				Form {
					Section("Recommended") {
						Text("placeholder")
					}
					Section {
						NavigationLink("Official", value: DownloadSheetPage.official)
						NavigationLink("Prerelease", value: DownloadSheetPage.prerelease)
						NavigationLink("Archive", value: DownloadSheetPage.archive)
					}
				}
				.formStyle(.grouped)
				.navigationDestination(for: DownloadSheetPage.self, destination: PageView.init)
				.navigationBarBackButtonHidden()
			}
		} header: {
			Button("Cancel", systemImage: Constant.Symbol.xMark, role: .cancel) { dismiss() }
				.controlSize(.large)
				.labelStyle(.iconOnly)

			Text("Download Installation")
				.font(.headline)

			Spacer()
		}
		.frame(width: 400)
	}
}
