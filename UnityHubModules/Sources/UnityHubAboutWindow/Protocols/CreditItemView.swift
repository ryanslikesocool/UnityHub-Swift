import SwiftUI

protocol CreditItemView: View {
	associatedtype C: CreditProtocol where C.ItemView == Self

	init(_ credit: C)
}
