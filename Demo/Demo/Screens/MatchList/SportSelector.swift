//
//  SportSelector.swift
//  Demo
//
//  Created by Nenad Prahovljanovic on 9. 12. 2025..
//
import SwiftUI

struct SportCategorySelector: View {
    let availableSports: [Sport]
    @Binding var selectedSportId: Int?

    var body: some View {
        HorizontalTabView(
            items: availableSports.map { $0.id },
            selected: $selectedSportId
        ) { id, isSelected in
            Group {
                if let sport = availableSports.first(where: { $0.id == id }) {
                    SportCategoryButton(sport: sport, isSelected: isSelected)
                }
            }
        }
    }
}

struct SportCategoryButton: View {
    let sport: Sport
    let isSelected: Bool

    var body: some View {
        HStack(spacing: 6) {
            if let url = sport.iconURL {
                // TODO: add svg
                Image(systemName: "bookmark.fill")
                    .frame(width: 22, height: 22)
                
            }
            Text(sport.name)
                .font(.system(size: 12, weight: .semibold))
        }
        .padding(8)
        .background(RoundedRectangle(cornerRadius: 8).fill(isSelected ? Color.yellow : Color(.systemGray5)))
        .foregroundColor(isSelected ? .black : .primary)
    }
}
