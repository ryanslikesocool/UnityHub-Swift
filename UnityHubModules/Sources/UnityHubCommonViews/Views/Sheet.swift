import SwiftUI

public struct Sheet<Content: View, Header: View, Footer: View>: View {
	public typealias ContentProvider = () -> Content
	public typealias HeaderProvider = () -> Header
	public typealias FooterProvider = () -> Footer

	private let content: ContentProvider
	private let header: HeaderProvider
	private let footer: FooterProvider

	public init(
		@ViewBuilder content: @escaping ContentProvider,
		@ViewBuilder header: @escaping HeaderProvider,
		@ViewBuilder footer: @escaping FooterProvider
	) {
		self.content = content
		self.header = header
		self.footer = footer
	}

	public var body: some View {
		VStack(spacing: 0) {
			if Header.self != EmptyView.self {
				bar(content: header)

				Divider()
			}

			content()

			if Footer.self != EmptyView.self {
				Divider()

				bar(content: footer)
			}
		}
	}

	private func bar<BarContent: View>(content: @escaping () -> BarContent) -> some View {
		HStack {
			content()
		}
		.padding(8)
		.background(.bar)
	}
}

// MARK: - Init+

public extension Sheet
	where Header == EmptyView
{
	init(
		@ViewBuilder content: @escaping ContentProvider,
		@ViewBuilder footer: @escaping FooterProvider
	) {
		self.init(content: content, header: EmptyView.init, footer: footer)
	}
}

public extension Sheet
	where Footer == EmptyView
{
	init(
		@ViewBuilder content: @escaping ContentProvider,
		@ViewBuilder header: @escaping HeaderProvider
	) {
		self.init(content: content, header: header, footer: EmptyView.init)
	}
}

public extension Sheet where
	Header == EmptyView,
	Footer == EmptyView
{
	init(
		@ViewBuilder content: @escaping ContentProvider
	) {
		self.init(content: content, header: EmptyView.init, footer: EmptyView.init)
	}
}
