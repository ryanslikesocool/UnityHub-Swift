import SwiftUI
import UnityHubCommon

public struct IssueMenu<Flags: IssueFlags, ItemLabel: View>: View {
	public typealias Action = (Flags) -> Void
	public typealias ItemLabelProvider = (Flags) -> ItemLabel

	private let flags: Flags
	private let action: Action
	private let itemLabel: ItemLabelProvider

	public init(
		flags: Flags,
		action: @escaping Action,
		@ViewBuilder itemLabel: @escaping ItemLabelProvider
	) {
		self.flags = flags
		self.action = action
		self.itemLabel = itemLabel
	}

	public var body: some View {
		Group {
			if !flags.isEmpty {
				if flags.count == 1 {
					button()
				} else {
					menu()
				}
			} else {
				Spacer()
					.frame(width: SmallMenuLabelStyle.width)
			}
		}
		.buttonStyle(.plain)
	}
}

// MARK: - Supporting Views

private extension IssueMenu {
	private func button() -> some View {
		Button(
			action: { action(flags) },
			label: Label.issue
		)
	}

	private func menu() -> some View {
		Menu(
			content: {
				ForEach(flags.enumerated, id: \.self) { flag in
					Button(action: { action(flag) }, label: { itemLabel(flag) })
				}
			},
			label: Label.issue
		)
		.menuIndicator(.hidden)
		.fixedSize()
	}
}
