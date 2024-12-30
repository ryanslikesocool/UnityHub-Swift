import SwiftUI

protocol AcknowledgementItemView: View {
	associatedtype A: Acknowledgement where A.ItemView == Self

	init(_ acknowledgement: A)
}