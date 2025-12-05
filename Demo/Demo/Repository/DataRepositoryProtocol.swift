//
//  DataRepositoryProtocol.swift
//  Demo
//
//  Created by Nenad Prahovljanovic on 5. 12. 2025..
//

protocol DataRepositoryProtocol {
    func load() -> AsyncStream<HomeFeedData>
}
