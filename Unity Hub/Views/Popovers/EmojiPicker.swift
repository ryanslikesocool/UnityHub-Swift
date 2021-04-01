//
//  EmojiPicker.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/25/20.
//

import Smile
import SwiftUI

struct EmojiPicker: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var emojiCategory: String = "people"
    @State private var emojiQuery: String = ""
    
    var action: (String) -> Void

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
        let gridItems = Array(repeating: GridItem(.flexible()), count: 8)
        
        VStack(alignment: .center, spacing: 0) {
            ScrollViewReader { scrollView in
                topBar()
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
                    .padding(.horizontal, 16)
                }
                .padding(.vertical, -8)
                bottomBar(scroll: scrollView)
            }
        }
        .frame(width: 320, height: 320)
    }
    
    func emojiCategories() -> some View {
        ForEach(categories[emojiCategory] ?? categories["people"]!, id: \.self) { emoji in
            Button(action: { selectEmoji(emoji: emoji) }) {
                Text(emoji)
            }
            .id(emoji)
            .help(Smile.name(emoji: emoji).first!.lowercased())
        }
    }
    
    func emojiSearch() -> some View {
        ForEach(categoryNames, id: \.self) { category in
            ForEach(categories[category]?.filter { Smile.name(emoji: $0).first!.lowercased().contains(emojiQuery.lowercased()) } ?? categories["people"]!, id: \.self) { emoji in
                Button(action: { selectEmoji(emoji: emoji) }) {
                    Text(emoji)
                }
                .id(emoji)
                .help(Smile.name(emoji: emoji).first!.lowercased())
            }
        }
    }
    
    func topBar() -> some View {
        Group {
            HStack {
                SearchBar(text: $emojiQuery)
                Button("None", action: { selectEmoji(emoji: "") })
                    .help("Remove the current emoji")
            }
            .padding(8)
        }
    }
    
    func bottomBar(scroll: ScrollViewProxy) -> some View {
        HStack {
            ForEach(categoryNames, id: \.self) { category in
                Button(action: {
                    emojiCategory = category
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                        scroll.scrollTo(categories[category]?.first)
                    }
                }) {
                    Text(categories[category]?.first ?? categories["people"]![0])
                }
                .help(category)
            }
        }
        .font(.system(size: 28))
        .buttonStyle(PlainButtonStyle())
        .padding(8)
    }
    
    func selectEmoji(emoji: String) {
        presentationMode.wrappedValue.dismiss()
        action(emoji)
    }
}
