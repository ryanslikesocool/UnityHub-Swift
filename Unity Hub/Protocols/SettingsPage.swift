import Foundation
import SwiftUI

protocol SettingsPage: View {
    associatedtype Tag: Hashable
    static var tag: Tag { get }

    associatedtype Content: View
    @ViewBuilder var content: Content { get }

    associatedtype LabelView: View
    @ViewBuilder static var label: LabelView { get }
}

extension SettingsPage {
    var body: some View {
        VStack {
            content
            Spacer()
        }
        .padding()
        .tabItem { Self.label }
        .tag(Self.tag)
    }
}
