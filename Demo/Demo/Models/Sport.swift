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
    let sportIconUrl: String
}
