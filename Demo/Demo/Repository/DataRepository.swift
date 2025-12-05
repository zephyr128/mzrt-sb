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

        let hasCacheData = cachedSportsDTOs != nil || cachedCompetitionsDTOs != nil || cachedMatchesDTOs != nil

        let cachedData = HomeFeedData(
            sports: cachedSportsDTOs?.map { Sport(dto: $0) },
            competitions: cachedCompetitionsDTOs?.map { Competition(dto: $0) },
            matches: cachedMatchesDTOs?.map { Match(dto: $0) },
            isInitialLoadComplete: true
        )
        
        if hasCacheData {
            continuation.yield(cachedData)
        } else {
            continuation.yield(HomeFeedData(isInitialLoadComplete: true))
        }
    }

    private func fetchNetworkUpdates(continuation: AsyncStream<HomeFeedData>.Continuation) async {
        
        async let sportsResult: [SportDTO]? = try? await networkService.request(endpoint: .sports)
        async let competitionsResult: [CompetitionDTO]? = try? await networkService.request(endpoint: .competitions)
        async let matchesResult: [MatchDTO]? = try? await networkService.request(endpoint: .matches)

        let (networkSports, networkCompetitions, networkMatches) = await (sportsResult, competitionsResult, matchesResult)
        
        // Sports Update
        if let sports = networkSports, !sports.isEmpty {
            await cacheService.save(sports, forKey: CacheKey.sports)
            continuation.yield(HomeFeedData(sports: sports.map { Sport(dto: $0) }, isInitialLoadComplete: true))
        }
        
        // Competitions Update
        if let competitions = networkCompetitions, !competitions.isEmpty {
            await cacheService.save(competitions, forKey: CacheKey.competitions)
            continuation.yield(HomeFeedData(competitions: competitions.map { Competition(dto: $0) }, isInitialLoadComplete: true))
        }

        // Matches Update
        if let matches = networkMatches, !matches.isEmpty {
            await cacheService.save(matches, forKey: CacheKey.matches)
            continuation.yield(HomeFeedData(matches: matches.map { Match(dto: $0) }, isInitialLoadComplete: true))
        }
    }
}
