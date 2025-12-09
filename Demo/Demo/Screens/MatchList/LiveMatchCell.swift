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
            
            HStack(spacing: 8) {
                if let url = item.competitionIcon {
                    SVGImageView(url: url)
                        .frame(width: 18, height: 18)
                }
                
                Text(item.competitionName)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                
                Spacer()
                
                if let current = item.currentTime {
                    Image(systemName: "play.rectangle.fill")
                        .foregroundColor(Color.teal)
                    Text(current)
                        .font(.system(size: 14))
                        .foregroundColor(Color.teal)
                }
            }
            
            // Teams & scores
            HStack {
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 8) {
                        if let url = item.homeTeamAvatarUrl {
                            SVGImageView(url: url)
                                .frame(width: 24, height: 24)
                        }
                        
                        Text(item.homeTeam)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    
                    HStack(spacing: 8) {
                        if let url = item.awayTeamAvatarUrl {
                            SVGImageView(url: url)
                                .frame(width: 24, height: 24)
                        }
                        
                        Text(item.awayTeam)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                    }
                }
                
                Spacer()
                
                VStack(spacing: 18) {
                    let homeResult = item.result?.home != nil ? "\(item.result!.home)" : "--"
                    let awayResult = item.result?.away != nil ? "\(item.result!.away)" : "--"

                    Text(homeResult)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)

                    Text(awayResult)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)
                }

            }
            
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.black.opacity(0.3))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.white.opacity(0.3), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
