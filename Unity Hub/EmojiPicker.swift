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
        
        ZStack {
            ScrollView {
                LazyVGrid(columns: gridItems, alignment: .leading, spacing: 4) {
                    ForEach(categories[emojiCategory] ?? categories["people"]!, id: \.self) { emoji in
                        Button(emoji, action: { selectEmoji(emoji: emoji) })
                        //.help(Smile.name(emoji: emoji))
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.top, 48)
                .padding(.bottom, 64)
            }.padding(.horizontal, 16)
            VStack(alignment: .center, spacing: 0) {
                HStack {
                    Button("Cancel", action: { presentationMode.wrappedValue.dismiss() })
                    Spacer()
                    Button("None", action: { selectEmoji(emoji: "") })
                        .help("Remove the current emoji")
                }
                .padding(8)
                .background(VisualEffectView(material: .headerView))
                .buttonStyle(UnityButtonStyle())
                Spacer()
                HStack {
                    ForEach(categoryNames, id: \.self) { category in
                        Button(categories[category]?[0] ?? categories["people"]![0], action: { selectCategory(category: category) })
                            .buttonStyle(PlainButtonStyle())
                            .font(.system(size: 28))
                            .help(category.capitalized)
                    }
                }
                .padding()
                .background(VisualEffectView(material: .headerView))
            }
        }
        .frame(width: 320, height: 320)
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
