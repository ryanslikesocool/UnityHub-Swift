//
//  SearchBar.swift
//  Unity Hub S
//
//  Created by RyanBoyer on 3/10/21.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
     
    @State private var isEditing = false
 
    var body: some View {
        TextField("Search", text: $text)
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}
