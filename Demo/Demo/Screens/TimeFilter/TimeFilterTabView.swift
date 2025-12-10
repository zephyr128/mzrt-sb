//
//  TimeFilterTabView.swift
//  Demo
//
//  Created by Nenad Prahovljanovic on 8. 12. 2025..
//

import SwiftUI

struct TimeFilterTabView: View {
    @Binding var selected: TimeFilter

    var body: some View {
        HorizontalTabView(items: TimeFilter.allCases, selected: $selected) { filter, isSelected in
            Text(filter.localizedName)
                .font(.system(size: 12, weight: .semibold))
                .padding(.horizontal, 18)
                .padding(.vertical, 14)
                .background(RoundedRectangle(cornerRadius: 8).fill(isSelected ? Color.primaryColor : Color.secondaryColor))
                .foregroundColor(isSelected ? Color.black : Color.primaryText)
        }
        .padding(.bottom, 8)
    }
}
