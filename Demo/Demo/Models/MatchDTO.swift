//
//  MatchDTO.swift
//  Demo
//
//  Created by Nenad Prahovljanovic on 5. 12. 2025..
//

struct ResultDTO: Codable {
    let home: Int
    let away: Int
}

struct MatchDTO: Codable {
    let id: Int
    let homeTeam: String
    let awayTeam: String
    let homeTeamAvatar: String?
    let awayTeamAvatar: String?
    let date: String
    let status: String
    let currentTime: String?
    let result: ResultDTO?
    let sportId: Int
    let competitionId: Int
}
