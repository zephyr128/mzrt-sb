//
//  Competition.swift
//  Demo
//
//  Created by Nenad Prahovljanovic on 5. 12. 2025..
//

import Foundation

struct Competition: Identifiable, Codable, Hashable {
    let id: Int
    let sportId: Int
    let name: String
    let competitionIconUrl: String
}
