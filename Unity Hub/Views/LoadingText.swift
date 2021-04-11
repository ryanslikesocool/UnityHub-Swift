//
//  LoadingText.swift
//  Unity Hub S
//
//  Created by RyanBoyer on 3/29/21.
//

import SwiftUI

struct LoadingText: View {
    @Binding var text: String
    
    var empty: Bool { return text == "" }
    var loading: Bool { return text == "." }

    var body: some View {
        if loading || empty {
            ProgressView()
                .frame(width: 16, height: 16)
                .scaleEffect(0.5)
        } else {
            Text(text)
        }
    }
}
