//
//  AppDependencies.swift
//  Demo
//
//  Created by Nenad Prahovljanovic on 5. 12. 2025..
//

final class AppDependencies {
    
    private let networkService: NetworkServiceProtocol
    private let cacheService: CacheServiceProtocol
    
    private let dataRepository: DataRepositoryProtocol
    
    init() {
        self.networkService = NetworkService()
        self.cacheService = FileCacheService()
        self.dataRepository = DataRepository(
            networkService: self.networkService,
            cacheService: self.cacheService
        )
    }
    
    @MainActor
    func makeMatchListViewModel() -> MatchListViewModel {
        return MatchListViewModel(repository: dataRepository)
    }
}
