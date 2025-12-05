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
    case unknown
}

struct MatchResult: Codable, Hashable {
    let home: Int
    let away: Int
    
    init(dto: ResultDTO) {
        self.home = dto.home
        self.away = dto.away
    }
}

struct Match: Identifiable, Codable, Hashable {
    let id: Int
    let homeTeam: String
    let awayTeam: String
    let homeTeamAvatarURL: URL?
    let awayTeamAvatarURL: URL?
    let date: Date?
    let status: MatchStatus
    let currentTime: String?
    let result: MatchResult?
    let sportId: Int
    let competitionId: Int

    init(dto: MatchDTO) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        formatter.locale = Locale(identifier: "en_US_POSIX")

        self.id = dto.id
        self.homeTeam = dto.homeTeam
        self.awayTeam = dto.awayTeam
        
        self.homeTeamAvatarURL = dto.homeTeamAvatar.flatMap { URL(string: $0) }
        self.awayTeamAvatarURL = dto.awayTeamAvatar.flatMap { URL(string: $0) }
        
        self.date = formatter.date(from: dto.date)
        
        self.status = MatchStatus(rawValue: dto.status) ?? .unknown
        
        self.currentTime = dto.currentTime
    
        self.result = dto.result.map(MatchResult.init)
        
        self.sportId = dto.sportId
        self.competitionId = dto.competitionId
    }
}
