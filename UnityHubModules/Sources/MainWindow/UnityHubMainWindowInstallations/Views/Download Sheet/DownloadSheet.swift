import SwiftUI
import UnityHubCommon
import UnityHubCommonViews

struct DownloadSheet: View {
	@Environment(\.dismiss) private var dismiss

	public init() { }

	public var body: some View {
		Sheet(
			content: makeContent,
			header: makeHeader
		)
		.frame(width: 400)
	}
}

// MARK: - Supporting Views

private extension DownloadSheet {
	func makeContent() -> some View {
		NavigationStack {
			Form {
				Section {
					Text("placeholder")
				} header: {
					Text(DownloadSheetTab.recommended.localizedStringResource)
				}
				Section {
					NavigationLink(DownloadSheetTab.official.localizedStringResource, value: DownloadSheetTab.official)
					NavigationLink(DownloadSheetTab.prerelease.localizedStringResource, value: DownloadSheetTab.prerelease)
					NavigationLink(DownloadSheetTab.archive.localizedStringResource, value: DownloadSheetTab.archive)
				}
			}
			.formStyle(.grouped)
			.navigationDestination(for: DownloadSheetTab.self, destination: SheetTab.init)
			.navigationBarBackButtonHidden()
		}
	}

	@ViewBuilder
	func makeHeader() -> some View {
		Button(
			String(localized: .common.action.cancel),
			systemImage: .xMark,
			role: .cancel
		) {
			dismiss()
		}
		.controlSize(.large)
		.labelStyle(.iconOnly)

		Text(.downloadSheet.title)
			.font(.headline)

		Spacer()
	}
}
