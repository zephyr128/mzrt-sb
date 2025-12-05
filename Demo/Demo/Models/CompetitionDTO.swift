//
//  CompetitionDTO.swift
//  Demo
//
//  Created by Nenad Prahovljanovic on 5. 12. 2025..
//

import Foundation

struct CompetitionDTO: Codable {
    let id: Int
    let sportId: Int
    let name: String
    let competitionIconUrl: String?
}
