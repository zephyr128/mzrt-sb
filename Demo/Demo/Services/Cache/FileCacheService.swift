//
//  FileCacheService.swift
//  Demo
//
//  Created by Nenad Prahovljanovic on 5. 12. 2025..
//

import Foundation

actor FileCacheService: CacheServiceProtocol {
    
    enum CacheError: Error {
        case directoryNotFound
    }
    
    // MARK: - Save
    func save<T: Codable>(_ items: [T], forKey key: String) async {
        do {
            let data = try JSONEncoder().encode(items)
            let url = try fileURL(forKey: key)
            try data.write(to: url, options: .atomic)
        } catch {
            Log.debug("CACHE ERROR [\(key)]: Failed to save data. Error: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Load
    func load<T: Codable>(forKey key: String) async -> [T]? {
        do {
            let url = try fileURL(forKey: key)
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([T].self, from: data)
        } catch {
            // silent fail
            return nil
        }
    }
    
    // MARK: - Private Helpers
    private func fileURL(forKey key: String) throws -> URL {
        guard let baseURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            throw CacheError.directoryNotFound
        }
        
        let appCacheURL = baseURL.appendingPathComponent("DemoAppCache", isDirectory: true)
        
        if !FileManager.default.fileExists(atPath: appCacheURL.path) {
             try FileManager.default.createDirectory(at: appCacheURL, withIntermediateDirectories: true)
        }
        
        return appCacheURL.appendingPathComponent("\(key).json")
    }
}
