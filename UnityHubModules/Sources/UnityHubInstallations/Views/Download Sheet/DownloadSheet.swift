import SwiftUI
import UnityHubCommon
import UnityHubCommonViews

struct DownloadSheet: View {
	@Environment(\.dismiss) private var dismiss

	public init() { }

	public var body: some View {
		Sheet(content: makeContent, header: makeHeader)
			.frame(width: 400)
	}
}

// MARK: - Supporting Views

private extension DownloadSheet {
	func makeContent() -> some View {
		NavigationStack {
			Form {
				Section("Recommended") {
					Text("placeholder")
				}
				Section {
					NavigationLink("Official", value: DownloadSheetTab.official)
					NavigationLink("Prerelease", value: DownloadSheetTab.prerelease)
					NavigationLink("Archive", value: DownloadSheetTab.archive)
				}
			}
			.formStyle(.grouped)
			.navigationDestination(for: DownloadSheetTab.self, destination: SheetTab.init)
			.navigationBarBackButtonHidden()
		}
	}

	@ViewBuilder
	func makeHeader() -> some View {
		Button("Cancel", systemImage: Constant.Symbol.xMark, role: .cancel) { dismiss() }
			.controlSize(.large)
			.labelStyle(.iconOnly)

		Text("Download Installation")
			.font(.headline)

		Spacer()
	}
}
