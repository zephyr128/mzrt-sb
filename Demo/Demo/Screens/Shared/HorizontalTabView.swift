//
//  HorizontalTabView.swift
//  Demo
//
//  Created by Nenad Prahovljanovic on 8. 12. 2025..
//

import SwiftUI

import SwiftUI

struct HorizontalTabView<Item: Hashable, Content: View>: View {
    let items: [Item]
    @Binding var selected: Item
    var spacing: CGFloat = 8
    var horizontalPadding: CGFloat = 8
    let content: (Item, Bool) -> Content

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: spacing) {
                    ForEach(items, id: \.self) { item in
                        content(item, item == selected)
                            .id(item)
                            .onTapGesture {
                                selected = item
                            }
                    }
                }
                .padding(.horizontal, horizontalPadding)
            }
            .onChange(of: selected) { old, newValue in
                withAnimation {
                    proxy.scrollTo(newValue, anchor: .center)
                }
            }
        }
    }
}

