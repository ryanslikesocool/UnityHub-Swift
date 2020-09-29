//
//  EmojiPicker.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/25/20.
//

import SwiftUI
import Smile

struct EmojiPicker: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var pickedEmoji: String
    @State private var emojiCategory: String = "people"
    
    var action: () -> Void

    let emojis = Array(Smile.emojiList.values)
    let categoryNames = [
        "people",
        "nature",
        "foods",
        "activity",
        "places",
        "objects",
        "symbols",
        "flags"
    ]
    let categories = Smile.emojiCategories

    var body: some View {
        let gridItems = [
             GridItem(.flexible()),
             GridItem(.flexible()),
             GridItem(.flexible()),
             GridItem(.flexible()),
             GridItem(.flexible()),
             GridItem(.flexible()),
             GridItem(.flexible()),
             GridItem(.flexible())
        ]
        
        VStack(alignment: .center, spacing: 0) {
            HStack {
                Spacer()
                Button("Clear", action: { selectEmoji(emoji: "") })
                Button("Cancel", action: { presentationMode.wrappedValue.dismiss() })
            }
            .font(.body)
            ScrollView {
                LazyVGrid(columns: gridItems, alignment: .leading, spacing: 4) {
                    ForEach(categories[emojiCategory] ?? categories["people"]!, id: \.self) { emoji in
                        Button(emoji, action: { selectEmoji(emoji: emoji) })
                        //.help(Smile.name(emoji: emoji))
                    }
                    .font(.system(size: 28))
                    .buttonStyle(PlainButtonStyle())
                }
            }
            HStack {
                ForEach(categoryNames, id: \.self) { category in
                    Button(categories[category]?[0] ?? categories["people"]![0], action: { selectCategory(category: category) })
                        .buttonStyle(PlainButtonStyle())
                        .font(.system(size: 24))
                }
            }
            .padding(.top, 4)
        }
        .frame(width: 320, height: 192)
        .padding()
    }
    
    func selectEmoji(emoji: String) {
        pickedEmoji = emoji
        presentationMode.wrappedValue.dismiss()
        action()
    }
    
    func selectCategory(category: String) {
        emojiCategory = category
    }
}

struct EmojiPicker_Previews: PreviewProvider {
    static var previews: some View {
        EmojiPicker(pickedEmoji: .constant("😀"), action: {})
    }
}
