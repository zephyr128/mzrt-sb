//
//  Endpoint.swift
//  Demo
//
//  Created by Nenad Prahovljanovic on 5. 12. 2025..
//

import Foundation

enum Endpoint {
    case matches
    case competitions
    case sports

    private var baseURL: String { "https://take-home-api-7m87.onrender.com/api" }
    
    var url: URL? {
        let path: String
        switch self {
        case .matches:
            path = "/matches"
        case .competitions:
            path = "/competitions"
        case .sports:
            path = "/sports"
        }
        return URL(string: baseURL + path)
    }
}
