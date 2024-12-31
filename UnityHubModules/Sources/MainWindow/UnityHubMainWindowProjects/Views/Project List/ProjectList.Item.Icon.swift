import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorageProjects
import UserIcon

extension ProjectList.Item {
	struct Icon: View {
		@Binding private var icon: UserIcon

		public init(_ icon: Binding<UserIcon>) {
			_icon = icon
		}

		public var body: some View {
			Group {
				if icon != .blank {
					UserIconView(icon)
				} else {
					Color.clear
				}
			}
			.aspectRatio(Self.aspectRatio, contentMode: Self.contentMode)
			.frame(width: Self.width)
		}
	}
}

// MARK: - Constants

private extension ProjectList.Item.Icon {
	static let aspectRatio: CGFloat = 1
	static let contentMode: ContentMode = .fit
	static var width: CGFloat { SmallMenuLabelStyle.height }
}
