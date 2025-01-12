import SwiftUI

protocol CreditItemView: View {
	associatedtype Item: CreditItem where Item.ItemView == Self

	init(_ item: Item)
}
