//
//  NetworkServiceProtocol.swift
//  Demo
//
//  Created by Nenad Prahovljanovic on 5. 12. 2025..
//

protocol NetworkServiceProtocol {
    func request<T: Decodable>(endpoint: Endpoint) async throws -> T
}
