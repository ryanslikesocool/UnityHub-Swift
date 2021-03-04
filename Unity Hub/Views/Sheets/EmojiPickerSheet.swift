//
//  EmojiPicker.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/25/20.
//

import SwiftUI
import Smile

struct EmojiPickerSheet: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var pickedEmoji: String
    @State private var emojiCategory: String = "people"
    @State private var emojiQuery: String = ""
    
    var action: () -> Void

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
                    if emojiQuery.isEmpty {
                        emojiCategories()
                    } else {
                        emojiSearch()
                    }
                }
                .font(.system(size: 28))
                .buttonStyle(PlainButtonStyle())
                .padding(.top, 48)
                .padding(.bottom, 64)
            }.padding(.horizontal, 16)
            VStack(alignment: .center, spacing: 0) {
                topBar()
                Spacer()
                bottomBar()
            }
        }
        .frame(width: 320, height: 320)
    }
    
    func emojiCategories() -> some View {
        ForEach(categories[emojiCategory] ?? categories["people"]!, id: \.self) { emoji in
            Button(emoji, action: { selectEmoji(emoji: emoji) })
            //.help(Smile.name(emoji: emoji))
        }
    }
    
    func emojiSearch() -> some View {
        ForEach(Smile.emojis(keywords: emojiQuery.components(separatedBy: " ")), id: \.self) { emoji in
            Button(emoji, action: { selectEmoji(emoji: emoji) })
        }
    }
    
    func topBar() -> some View {
        HStack {
            Button("Cancel", action: { presentationMode.wrappedValue.dismiss() })
                .foregroundColor(.textColor)
            Spacer()
            /*Image(systemName: "magnifyingglass")
            TextField("", text: $emojiQuery)*/
            Button("None", action: { selectEmoji(emoji: "") })
                .help("Remove the current emoji")
                .foregroundColor(.textColor)
        }
        .padding(8)
        .background(VisualEffectView(material: .headerView))
        //.buttonStyle(PlainButtonStyle())
    }
    
    func bottomBar() -> some View {
        HStack {
            ForEach(categoryNames, id: \.self) { category in
                Button(categories[category]?[0] ?? categories["people"]![0], action: { selectCategory(category: category) })
                    .buttonStyle(PlainButtonStyle())
                    .font(.system(size: 28))
                    .help(category.capitalized)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(VisualEffectView(material: .headerView))
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
        EmojiPickerSheet(pickedEmoji: .constant("😀"), action: {})
    }
}
