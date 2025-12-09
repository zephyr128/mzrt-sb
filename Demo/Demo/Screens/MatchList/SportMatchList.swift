//
//  SportMatchList.swift
//  Demo
//
//  Created by Nenad Prahovljanovic on 9. 12. 2025..
//

import SwiftUI

struct SportMatchesList: View {
    let matches: [MatchDisplayItem]
    @State var timeFilter: TimeFilter = .today
    
    private var prematchMatches: [MatchDisplayItem] {
        let now = Date()
        return matches
            .filter { $0.status != .live }
            .filter { match in
                guard let start = match.startTime else { return false }
                return timeFilter.matches(date: start)
            }
            .sorted { $0.startTime ?? now < $1.startTime ?? now }
    }
    
    private var liveMatches: [MatchDisplayItem] {
        matches.filter { $0.status == .live }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
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
            
            sectionHeader
                .padding(8)

            if isPrematch {
                TimeFilterTabView(selected: $timeFilter)
            }
            
            if matches.isEmpty {
                EmptyStateView(title: "Nema dostupnih mečeva", message: "")
            }

            Group {
                ForEach(matches, id: \.id) { match in
                    if isPrematch {
                        PrematchCell(item: match)
                    } else {
                        LiveMatchCell(item: match)
                    }
                }
            }.padding(.horizontal, 8)
        }
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder var sectionHeader: some View {
        HStack(spacing: 6) {
            Rectangle()
                .frame(width: 2)
                .frame(maxHeight: .infinity)
                .foregroundColor(.yellow)
            Text(title.uppercased())
                .font(.system(size: 16).weight(.heavy))
                .foregroundColor(.white)
            Spacer()
        }
    }
}
