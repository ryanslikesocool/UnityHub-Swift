import OSLog
import SwiftUI
import UnityHubCommon
import UnityHubStorageProjects
import UserIcon

extension ProjectInfoSheet {
	struct FileSizeLabel: View {
		private let url: URL

		@State private var phase: Phase = .loading

		init(at url: URL) {
			self.url = url
		}

		var body: some View {
			LabeledContent("Size") {
				content
			}
			.task {
				await recalculateFileSizeAsync()
			}
		}
	}
}

// MARK: - Supporting Views

private extension ProjectInfoSheet.FileSizeLabel {
	@ViewBuilder
	var content: some View {
		switch phase {
			case .loading:
				ProgressView()
					.controlSize(.mini)
			case .failed:
				Button(
					action: recalculateFileSize,
					label: Label.retry
				)
				.controlSize(.small)
			case let .complete(value):
				Text(value)
					.monospaced()
		}
	}
}

// MARK: - Functions

private extension ProjectInfoSheet.FileSizeLabel {
	func recalculateFileSize() {
		Task {
			await recalculateFileSizeAsync()
		}
	}

	func recalculateFileSizeAsync() async {
		phase = .loading

		let newFileSize: String?
		do {
			newFileSize = try url.sizeOnDisk()
		} catch {
			Logger.module.error("""
			Failed to calculate file size.
			- Path: \(url.path(percentEncoded: false))
			- Error: \(error.localizedDescription)
			""")
			newFileSize = nil
		}

		if let newFileSize {
			phase = .complete(newFileSize)
			Logger.module.debug("""
			Finished calculating project file size.
			- Path: \(url.path(percentEncoded: false))
			- Size: \(String(describing: newFileSize))
			""")
		} else {
			phase = .failed
		}
	}
}

// MARK: - Supporting Data

private extension ProjectInfoSheet.FileSizeLabel {
	enum Phase {
		case loading
		case failed
		case complete(String)
	}
}
