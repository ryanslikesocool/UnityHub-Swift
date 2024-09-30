/// Copyright © 2022 Apple Inc.
/// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
/// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import SwiftUI

/// A custom horizontal stack that offers all its subviews the width of its
/// widest subview.
///
/// This custom layout arranges views horizontally, giving each the width needed
/// by the widest subview.
///
/// ![Three rectangles arranged in a horizontal line. Each rectangle contains
/// one smaller rectangle. The smaller rectangles have varying widths. Dashed
/// lines above each of the container rectangles show that the larger rectangles
/// all have the same width as each other.](voting-buttons)
///
/// The custom stack implements the protocol's two required methods. First,
/// ``sizeThatFits(proposal:subviews:cache:)`` reports the container's size,
/// given a set of subviews.
///
/// ```swift
/// let maxSize = maxSize(subviews: subviews)
/// let spacing = spacing(subviews: subviews)
/// let totalSpacing = spacing.reduce(0) { $0 + $1 }
///
/// return CGSize(
///     width: maxSize.width * CGFloat(subviews.count) + totalSpacing,
///     height: maxSize.height)
/// ```
///
/// This method combines the largest size in each dimension with the horizontal
/// spacing between subviews to find the container's total size. Then,
/// ``placeSubviews(in:proposal:subviews:cache:)`` tells each of the subviews
/// where to appear within the layout's bounds.
///
/// ```swift
/// let maxSize = maxSize(subviews: subviews)
/// let spacing = spacing(subviews: subviews)
///
/// let placementProposal = ProposedViewSize(width: maxSize.width, height: maxSize.height)
/// var nextX = bounds.minX + maxSize.width / 2
///
/// for index in subviews.indices {
///     subviews[index].place(
///         at: CGPoint(x: nextX, y: bounds.midY),
///         anchor: .center,
///         proposal: placementProposal)
///     nextX += maxSize.width + spacing[index]
/// }
/// ```
///
/// The method creates a single size proposal for the subviews, and then uses
/// that, along with a point that changes for each subview, to arrange the
/// subviews in a horizontal line with default spacing.
public struct EqualWidthHStackLayout: Layout {
	public init() { }

	/// Returns a size that the layout container needs to arrange its subviews
	/// horizontally.
	/// - Tag: sizeThatFitsHorizontal
	public func sizeThatFits(
		proposal: ProposedViewSize,
		subviews: Subviews,
		cache: inout CacheData
	) -> CGSize {
		guard !subviews.isEmpty else {
			return .zero
		}

		let (maxSize, subviewSizes) = maxSize(subviews: subviews)
		let spacing = spacing(subviews: subviews)
		let totalSpacing: CGFloat = spacing.reduce(CGFloat.zero, +)

		return CGSize(
//			width:  maxSize.width * CGFloat(subviews.count) + totalSpacing,
			width: subviewSizes.map(\.width).reduce(CGFloat.zero, +) + totalSpacing,
			height: maxSize.height
		)
	}

	/// Places the subviews in a horizontal stack.
	/// - Tag: placeSubviewsHorizontal
	public func placeSubviews(
		in bounds: CGRect,
		proposal: ProposedViewSize,
		subviews: Subviews,
		cache: inout CacheData
	) {
		guard !subviews.isEmpty else {
			return
		}

		let (maxSize, subviewSizes) = maxSize(subviews: subviews)
		let spacing = spacing(subviews: subviews)

		let placementProposals = subviewSizes.map { subviewSize in
			ProposedViewSize(width: subviewSize.width, height: subviewSize.height)
		}

		var nextX = bounds.minX + maxSize.width * 0.5

		for index in subviews.indices {
			subviews[index].place(
				at: CGPoint(x: nextX, y: bounds.midY),
				anchor: .center,
				proposal: placementProposals[index]
			)
			nextX += subviewSizes[index].width * 0.5 + spacing[index]

			if index != subviews.indices.last {
				nextX += subviewSizes[index + 1].width * 0.5
			}
		}
	}

	public func makeCache(subviews: Subviews) -> CacheData {
		let (maxSize, subviewSizes) = maxSize(subviews: subviews)
		let spacing = spacing(subviews: subviews)
		let totalSpacing = spacing.reduce(0, +)

		return CacheData(
			maxSize: maxSize,
			subviewSizes: subviewSizes,
			spacing: spacing,
			totalSpacing: totalSpacing
		)
	}
}

// MARK: - Functions

extension EqualWidthHStackLayout {
	/// Finds the largest ideal size of the subviews.
	private func maxSize(subviews: Subviews) -> (maxSize: CGSize, subviewSizes: [CGSize]) {
		let subviewSizes: [(CGSize, Axis.Set)] = subviewSizes(subviews: subviews)

		var maxSize: CGSize = .zero
		for (subviewSize, ignoreAxis) in subviewSizes {
			if !ignoreAxis.contains(.horizontal) {
				maxSize.width = max(maxSize.width, subviewSize.width)
			}
			if !ignoreAxis.contains(.vertical) {
				maxSize.height = max(maxSize.height, subviewSize.height)
			}
		}

		let finalSubviewSizes: [CGSize] = subviewSizes.map { subviewSize, ignoreAxis in
			var size = subviewSize

			if !ignoreAxis.contains(.horizontal) {
				size.width = maxSize.width
			}
			if !ignoreAxis.contains(.vertical) {
				size.height = maxSize.height
			}

			return size
		}

		return (maxSize, finalSubviewSizes)
	}

	private func subviewSizes(subviews: Subviews) -> [(size: CGSize, ignoreAxis: Axis.Set)] {
		if #available(macOS 15, *) {
			subviews.map { subview in
				let size = subview.sizeThatFits(.unspecified)
				let ignoresAxis = subview.containerValues.ignoresEqualSizeLayout
				return (size, ignoresAxis)
			}
		} else {
			subviews.map { subview in
				let size = subview.sizeThatFits(.unspecified)
				return (size, [])
			}
		}
	}

	/// Gets an array of preferred spacing sizes between subviews in the
	/// horizontal dimension.
	private func spacing(subviews: Subviews) -> [CGFloat] {
		subviews.indices.map { index in
			guard index < subviews.count - 1 else {
				return 0
			}

			return subviews[index].spacing.distance(
				to: subviews[index + 1].spacing,
				along: .horizontal
			)
		}
	}
}

// MARK: - Supporting Data

public extension EqualWidthHStackLayout {
	struct CacheData {
		fileprivate let maxSize: CGSize
		fileprivate let subviewSizes: [CGSize]
		fileprivate let spacing: [CGFloat]
		fileprivate let totalSpacing: CGFloat
	}
}
