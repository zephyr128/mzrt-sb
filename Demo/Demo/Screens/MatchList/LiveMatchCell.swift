//
//  LiveMatchCell.swift
//  Demo
//
//  Created by Nenad Prahovljanovic on 9. 12. 2025..
//

import SwiftUI

struct LiveMatchCell: View {
    let item: MatchDisplayItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            // Competition + current time
            HStack(spacing: 8) {
                if let url = item.competitionIcon {
                    SVGImageView(url: url)
                        .frame(width: 18, height: 18)
                }
                
                Text(item.competitionName)
                    .font(.system(size: 12))
                    .foregroundColor(.secondaryText)
                
                Spacer()
                
                if let current = item.currentTime {
                    Image(systemName: "play.rectangle.fill")
                        .foregroundColor(.accentColor)
                        .frame(width: 18, height: 18)
                    Text(current)
                        .font(.system(size: 12))
                        .foregroundColor(.accentColor)
                }
            }
            
            // Teams & scores
            HStack {
                VStack(alignment: .leading, spacing: 12) {
                    TeamView(name: item.homeTeam, avatarURL: item.homeTeamAvatarUrl)
                    TeamView(name: item.awayTeam, avatarURL: item.awayTeamAvatarUrl)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: 18) {
                    let homeResult = item.result?.home != nil ? "\(item.result!.home)" : "--"
                    let awayResult = item.result?.away != nil ? "\(item.result!.away)" : "--"
                    
                    Text(homeResult)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.primaryText)
                    
                    Text(awayResult)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.primaryText)
                }
            }
        }
        .padding()
        .background(Color.black.opacity(0.3))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.borderGray, lineWidth: 1)
        )
    }
}

// MARK: - Team View

private struct TeamView: View {
    let name: String
    let avatarURL: URL?
    
    var body: some View {
        HStack(spacing: 8) {
            if let url = avatarURL {
                SVGImageView(url: url)
                    .frame(width: 24, height: 24)
            }
            Text(name)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.primaryText)
        }
    }
}

