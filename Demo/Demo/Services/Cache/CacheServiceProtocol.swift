//
//  CacheServiceProtocol.swift
//  Demo
//
//  Created by Nenad Prahovljanovic on 5. 12. 2025..
//

protocol CacheServiceProtocol {
    func load<T: Codable>(forKey key: String) async -> [T]?
    func save<T: Codable>(_ items: [T], forKey key: String) async
}
