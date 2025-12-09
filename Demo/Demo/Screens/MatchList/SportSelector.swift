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

    private var sportById: [Int: Sport] {
        Dictionary(uniqueKeysWithValues: availableSports.map { ($0.id, $0) })
    }

    var body: some View {
        HorizontalTabView(
            items: availableSports.map { $0.id },
            selected: $selectedSportId
        ) { id, isSelected in
            Group {
                if let id, let sport = sportById[id] {
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
                SVGImageView(url: url)
                    .frame(width: 24, height: 24)
            }
            Text(sport.name)
                .font(.system(size: 12, weight: .semibold))
                .lineLimit(1)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(isSelected ? Color.primaryColor : Color.secondaryColor)
        )
        .foregroundColor(isSelected ? Color.black : Color.primaryText)
        .animation(.easeInOut(duration: 0.15), value: isSelected)
    }
}

