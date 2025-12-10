//
//  SportMatchList.swift
//  Demo
//
//  Created by Nenad Prahovljanovic on 9. 12. 2025..
//

import SwiftUI

struct SportMatchesList: View {
    let matches: [MatchDisplayItem]
    @State private var timeFilter: TimeFilter = .today
    private let now = Date()
    
    private var prematchMatches: [MatchDisplayItem] {
        matches
            .filter { $0.status != .live }
            .filter { match in
                guard let start = match.startTime else { return false }
                return timeFilter.matches(date: start)
            }
            .sorted { ($0.startTime ?? now) < ($1.startTime ?? now) }
    }
    
    private var liveMatches: [MatchDisplayItem] {
        matches.filter { $0.status == .live }
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 20, pinnedViews: []) {
                MatchSection(title: "MEČEVI UŽIVO", matches: liveMatches)
                MatchSection(title: "PREMATCH PONUDA",
                                 matches: prematchMatches,
                                 isPrematch: true,
                                 timeFilter: $timeFilter)
            }
            .padding(.top, 16)
        }
    }
}

// MARK: - MatchSection

struct MatchSection: View {
    let title: String
    let matches: [MatchDisplayItem]
    var isPrematch: Bool = false
    @Binding var timeFilter: TimeFilter

    init(title: String, matches: [MatchDisplayItem], isPrematch: Bool = false, timeFilter: Binding<TimeFilter>? = nil) {
        self.title = title
        self.matches = matches
        self.isPrematch = isPrematch
        self._timeFilter = timeFilter ?? .constant(.today)
    }

    var body: some View {
        VStack(spacing: 8) {
            SectionHeader(title: title)
                .padding(8)
            
            if isPrematch {
                TimeFilterTabView(selected: $timeFilter)
            }
            
            if matches.isEmpty {
                EmptyStateView(title: "Nema dostupnih mečeva", message: "Za izabrani period nema dostupnih mečeva")
                    .padding(.vertical)
            } else {
                LazyVStack(spacing: 12) {
                    ForEach(matches, id: \.id) { match in
                        Group {
                            if isPrematch {
                                PrematchCell(item: match)
                            } else {
                                LiveMatchCell(item: match)
                            }
                        }
                    }
                }
                .padding(.horizontal, 8)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - SectionHeader

struct SectionHeader: View {
    let title: String
    
    var body: some View {
        HStack(spacing: 6) {
            Rectangle()
                .frame(width: 2)
                .frame(maxHeight: .infinity)
                .foregroundColor(.primaryColor)
            
            Text(title.uppercased())
                .font(.system(size: 16, weight: .heavy))
                .foregroundColor(.primaryText)
            
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

