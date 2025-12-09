//
//  PrematchCell.swift
//  Demo
//
//  Created by Nenad Prahovljanovic on 9. 12. 2025..
//

import SwiftUI

struct PrematchCell: View {
    let item: MatchDisplayItem
    
    var body: some View {
        HStack(spacing: 8) {
            
            // MARK: Home Team
            teamBlock(name: item.homeTeam, avatarURL: item.homeTeamAvatarUrl)
            
            // MARK: Middle Block
            VStack(spacing: 2) {
                if let url = item.competitionIcon {
                    SVGImageView(url: url)
                        .frame(width: 24, height: 24)
                }
                
                Text(item.competitionName)
                    .font(.system(size: 8))
                    .foregroundColor(.gray)
                
                Text(formattedDate)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white)
                
                Text(formattedTime)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            
            // MARK: Away Team
            teamBlock(name: item.awayTeam, avatarURL: item.awayTeamAvatarUrl)
        }
        .multilineTextAlignment(.center)
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.black.opacity(0.1))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.white.opacity(0.3), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    // MARK: - Team Block View
    private func teamBlock(name: String, avatarURL: URL?) -> some View {
        VStack {
            if let url = avatarURL {
                SVGImageView(url: url)
                    .frame(width: 48, height: 48)
            }
            Text(name)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.white)
                .lineLimit(2)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
    }
    
    // MARK: - Computed Properties
    private var formattedDate: String {
        guard let date = item.startTime else { return "" }
        let calendar = Calendar.current
        
        if calendar.isDateInToday(date) {
            return NSLocalizedString("Danas", comment: "Today")
        } else if calendar.isDateInTomorrow(date) {
            return NSLocalizedString("Sutra", comment: "Tomorrow")
        } else {
            // Weekend or other day: show localized day + month
            let formatter = DateFormatter()
            formatter.locale = Locale.current
            formatter.dateFormat = "dd.MM"
            return formatter.string(from: date)
        }
    }
    
    private var formattedTime: String {
        guard let date = item.startTime else { return "" }
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}
