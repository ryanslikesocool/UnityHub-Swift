import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

extension ProjectList.Item {
	struct NameLabel: View {
		private let project: ProjectMetadata

		init(_ project: ProjectMetadata) {
			self.project = project
		}

		var body: some View {
			HStack(spacing: 0) {
				if project.pinned {
					Image(systemName: Constant.Symbol.pin_fill)
						.foregroundStyle(.orange)
						.scaleEffect(0.7)
						.rotationEffect(.degrees(-45))
						.offset(y: 1)
				}

				Text(project.name ?? project.url.lastPathComponent)
			}
			.font(.headline)
		}
	}
}
