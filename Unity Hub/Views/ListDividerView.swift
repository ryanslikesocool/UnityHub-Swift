//
//  ListDividerView.swift
//  Unity Hub S
//
//  Created by RyanBoyer on 3/4/21.
//

import SwiftUI

struct ListDividerView: View {
    var body: some View {
        Rectangle()
            .frame(minWidth: 64, maxWidth: .infinity, minHeight: 1, maxHeight: 1, alignment: .center)
            .foregroundColor(.systemGray4)
    }
}

struct ListDividerView_Previews: PreviewProvider {
    static var previews: some View {
        ListDividerView()
    }
}
