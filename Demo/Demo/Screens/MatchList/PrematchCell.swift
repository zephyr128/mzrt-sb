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
        VStack(alignment: .center, spacing: 12) {
            
            HStack(spacing: 8) {
                if let url = item.competitionIcon {
                    // TODO: Add svg
                }
                
                Text(item.competitionName)
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.7))
            }
            
            Text(item.startTime ?? Date(), style: .date)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.white)
            Text(item.startTime ?? Date(), style: .time)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
            
            HStack(spacing: 40) {
                VStack {
                    if let url = item.homeTeamAvatarUrl {
                        // TODO: Add svg
                    }
                    Text(item.name.split(separator: "vs")[0].trimmingCharacters(in: .whitespaces))
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                }
                
                VStack {
                    if let url = item.awayTeamAvatarUrl {
                        // TODO: Add svg
                    }
                    Text(item.name.split(separator: "vs")[1].trimmingCharacters(in: .whitespaces))
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.black.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
