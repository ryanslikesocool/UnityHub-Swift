import OSLog
import SwiftUI
import UnityHubCommon
import UnityHubStorage
import UserIcon

extension ProjectInfoView {
	struct FileSizeLabel: View {
		private let url: URL

		@State private var isLoading: Bool = false
		@State private var fileSize: String? = nil

		init(at url: URL) {
			self.url = url
		}

		var body: some View {
			LabeledContent("Size") {
				content
			}
			.task { await recalculateFileSize() }
		}
	}
}

// MARK: - Supporting Views

private extension ProjectInfoView.FileSizeLabel {
	@ViewBuilder var content: some View {
		if let fileSize {
			Text(fileSize)
				.monospaced()
		} else if isLoading {
			ProgressView()
				.controlSize(.mini)
		} else {
			Button("Retry", systemImage: "arrow.clockwise") {
				Task {
					recalculateFileSize
				}
			}
			.controlSize(.small)
		}
	}
}

// MARK: - Functions

private extension ProjectInfoView.FileSizeLabel {
	func recalculateFileSize() async {
		isLoading = true

		let newFileSize: String?
		do {
			newFileSize = try url.sizeOnDisk()
		} catch {
			Logger.module.error("""
			Failed to calculate file size for \(url.path(percentEncoded: false)):
			\(error.localizedDescription)
			""")
			newFileSize = nil
		}

		fileSize = newFileSize

		Logger.module.debug("Finished recalculating file size for the project at \(url.path(percentEncoded: false)) with result \(String(describing: newFileSize)).")

		isLoading = false
	}
}
