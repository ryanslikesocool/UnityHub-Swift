//
//  EmojiPickerButton.swift
//  Unity Hub S
//
//  Created by RyanBoyer on 4/1/21.
//

import Smile
import SwiftUI

struct EmojiPickerButton: View {
    let emoji: String
    let action: (String) -> Void

    var body: some View {
        Button(action: { action(emoji) }) {
            Text(emoji)
        }
        .id(emoji)
        .help(Smile.name(emoji: emoji).first!.lowercased())
    }
}
