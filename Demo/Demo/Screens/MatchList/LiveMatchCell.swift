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
                    // TODO: add svg
                }
                
                Text(item.competitionName)
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.75))
                
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
                           // TODO: Add svg
                        }
                        
                        Text(item.name.split(separator: "vs")[0].trimmingCharacters(in: .whitespaces))
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    
                    HStack(spacing: 8) {
                        if let url = item.awayTeamAvatarUrl {
                            // TODO: Add svg
                        }
                        
                        Text(item.name.split(separator: "vs")[1].trimmingCharacters(in: .whitespaces))
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
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
