//
//  Match.swift
//  Demo
//
//  Created by Nenad Prahovljanovic on 5. 12. 2025..
//

import Foundation

enum MatchStatus: String, Codable, Hashable {
    case preMatch = "PRE_MATCH"
    case live = "LIVE"
    case finished = "FINISHED"
}

struct Match: Identifiable, Codable, Hashable {
    let id: Int
    let homeTeam: String
    let awayTeam: String
    let homeTeamAvatar: String
    let awayTeamAvatar: String
    let date: String
    let status: MatchStatus
    let currentTime: String?
    let result: String?
    let sportId: Int
    let competitionId: Int
}
