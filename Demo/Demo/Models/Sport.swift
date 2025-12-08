//
//  Sport.swift
//  Demo
//
//  Created by Nenad Prahovljanovic on 5. 12. 2025..
//

import Foundation

struct Sport: Identifiable, Codable, Hashable {
    let id: Int
    let name: String
    let iconURL: URL?
    
    init(dto: SportDTO) {
        self.id = dto.id
        self.name = dto.name
        self.iconURL = URL(string: dto.sportIconUrl)
    }
}
