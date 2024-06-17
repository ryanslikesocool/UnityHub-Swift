import SwiftUI
import UnityHubStorage

public struct UnityEditorVersionBadgeView: View {
	private let text: String?
	private let color: Color

	public init(_ value: UnityEditorVersion) {
		if value.channel == .alpha {
			text = "Alpha"
			color = .red
		} else if value.channel == .beta {
			text = "Beta"
			color = .yellow
		} else if value.isLTS {
			text = "LTS"
			color = .gray
		} else {
			text = nil
			color = .clear
		}
	}

	public var body: some View {
		if let text {
			Text(text)
				.opacity(0.75)
				.font(.caption.weight(.semibold))
				.padding(3)
				.background(color.opacity(0.2), in: containerShape)
				.overlay(color.opacity(0.1), in: containerShape.stroke(lineWidth: 1))
				.textSelection(.disabled)
		}
	}

	private var containerShape: some Shape {
		RoundedRectangle(cornerRadius: 4)
	}
}
