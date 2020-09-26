//
//  EmojiPicker.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/25/20.
//

import Foundation
import SwiftUI
import Smile

struct EmojiPickerButton: View {    
    @Binding var emoji: String
    @State private var isPickerOpen: Bool = false
    
    var action: () -> Void
    
    var body: some View {
        Button(action: { isPickerOpen.toggle() }) {
            Text(emoji)
        }.sheet(isPresented: $isPickerOpen, content: {
            EmojiPicker(pickedEmoji: $emoji, action: action)
        })
        .buttonStyle(PlainButtonStyle())
    }
}

struct EmojiPickerButton_Previews: PreviewProvider {
    static var previews: some View {
        EmojiPicker(pickedEmoji: .constant("😀"), action: {})
    }
}
