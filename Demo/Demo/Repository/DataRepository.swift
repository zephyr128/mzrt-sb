//
//  DataRepository.swift
//  Demo
//
//  Created by Nenad Prahovljanovic on 5. 12. 2025..
//

final class DataRepository: DataRepositoryProtocol {
    
    private let networkService: NetworkServiceProtocol
    private let cacheService: CacheServiceProtocol

    init(networkService: NetworkServiceProtocol, cacheService: CacheServiceProtocol) {
        self.networkService = networkService
        self.cacheService = cacheService
    }

    func load() -> AsyncStream<HomeFeedData> {
        return AsyncStream { continuation in
            Task {
                await loadCachedData(continuation: continuation)
                await fetchNetworkUpdates(continuation: continuation)
                continuation.finish()
            }
        }
    }

    private func loadCachedData(continuation: AsyncStream<HomeFeedData>.Continuation) async {
        let cachedSportsDTOs: [SportDTO]? = await cacheService.load(forKey: CacheKey.sports)
        let cachedCompetitionsDTOs: [CompetitionDTO]? = await cacheService.load(forKey: CacheKey.competitions)
        let cachedMatchesDTOs: [MatchDTO]? = await cacheService.load(forKey: CacheKey.matches)
        
        continuation.yield(HomeFeedData(
            sports: cachedSportsDTOs?.map { Sport(dto: $0) },
            competitions: cachedCompetitionsDTOs?.map { Competition(dto: $0) },
            matches: cachedMatchesDTOs?.map { Match(dto: $0) },
            isInitialLoadComplete: false,
            error: nil
        ))
    }

    private func fetchNetworkUpdates(continuation: AsyncStream<HomeFeedData>.Continuation) async {
        do {
            async let sportsResult: [SportDTO]? = fetchAndCache(endpoint: .sports, cacheKey: CacheKey.sports)
            async let competitionsResult: [CompetitionDTO]? = fetchAndCache(endpoint: .competitions, cacheKey: CacheKey.competitions)
            async let matchesResult: [MatchDTO]? = fetchAndCache(endpoint: .matches, cacheKey: CacheKey.matches)
            
            let sports = try await sportsResult
            let competitions = try await competitionsResult
            let matches = try await matchesResult
            
            continuation.yield(HomeFeedData(
                sports: sports?.map { Sport(dto: $0) },
                competitions: competitions?.map { Competition(dto: $0) },
                matches: matches?.map { Match(dto: $0) },
                isInitialLoadComplete: true,
                error: nil
            ))
        } catch {
            continuation.yield(HomeFeedData(
                sports: nil,
                competitions: nil,
                matches: nil,
                isInitialLoadComplete: true,
                error: error
            ))
        }
    }
    
    private func fetchAndCache<T: Codable>(endpoint: Endpoint, cacheKey: String) async throws -> [T]? {
        let data: [T]? = try await networkService.request(endpoint: endpoint)
        if let data = data, !data.isEmpty {
            await cacheService.save(data, forKey: cacheKey)
        }
        return data
    }
}
