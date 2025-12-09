//
//  MatchListViewModel.swift
//  Demo
//
//  Created by Nenad Prahovljanovic on 5. 12. 2025..
//

import Foundation
import SwiftUI
import Combine

// MARK: - Display Model

struct MatchDisplayItem: Identifiable, Hashable {
    let id: Int
    let name: String
    let startTime: Date?
    let status: MatchStatus
    let currentTime: String?
    let result: MatchResult?
    let homeTeamAvatarUrl: URL?
    let awayTeamAvatarUrl: URL?
    let sportId: Int
    let competitionName: String
    let competitionIcon: URL?
    let sportName: String
    let sportIconUrl: URL?
}

// MARK: - ViewModel

@MainActor
final class MatchListViewModel: ObservableObject {

    // MARK: - State

    enum ViewState {
        case loading
        case content
        case empty
        case error(String)
    }

    @Published var viewState: ViewState = .loading
    @Published var availableSports: [Sport] = []
    @Published var matchesBySport: [Int: [MatchDisplayItem]] = [:]

    // MARK: - Internal Data Maps

    private var allMatches: [Match] = []
    private var sportsMap: [Int: Sport] = [:]
    private var competitionsMap: [Int: Competition] = [:]

    // MARK: - Infrastructure

    private let repository: DataRepositoryProtocol
    private var streamTask: Task<Void, Never>?
    private var hasLoadedAnyMatches: Bool = false

    // MARK: - Init

    init(repository: DataRepositoryProtocol) {
        self.repository = repository
    }

    deinit {
        streamTask?.cancel()
    }

    // MARK: - Public API

    func loadData() {
        resetState()
        startStreaming()
    }

    // MARK: - Private Helpers

    private func resetState() {
        viewState = .loading
        allMatches = []
        sportsMap = [:]
        competitionsMap = [:]
        availableSports = []
        matchesBySport = [:]
        hasLoadedAnyMatches = false
        streamTask?.cancel()
    }

    private func startStreaming() {
        streamTask = Task {
            for await data in repository.load() {
                processIncomingPayload(data)
            }
        }
    }

    private func processIncomingPayload(_ payload: HomeFeedData) {
        if let error = payload.error, !hasLoadedAnyMatches {
            viewState = .error(error.localizedDescription)
            return
        }
        
        updateSports(from: payload)
        updateCompetitions(from: payload)
        updateMatches(from: payload)

        rebuildDisplayData()

        updateViewState(isInitial: payload.isInitialLoadComplete)
    }

    // MARK: - Data Processing

    private func updateSports(from payload: HomeFeedData) {
        guard let sports = payload.sports, !sports.isEmpty else { return }
        availableSports = sports
        sportsMap = Dictionary(uniqueKeysWithValues: sports.map { ($0.id, $0) })
    }

    private func updateCompetitions(from payload: HomeFeedData) {
        guard let comps = payload.competitions, !comps.isEmpty else { return }
        competitionsMap = Dictionary(uniqueKeysWithValues: comps.map { ($0.id, $0) })
    }

    private func updateMatches(from payload: HomeFeedData) {
        guard let matches = payload.matches, !matches.isEmpty else { return }
        allMatches = matches
        hasLoadedAnyMatches = true
    }

    // MARK: - Display Mapping

    private func rebuildDisplayData() {
        var grouped: [Int: [MatchDisplayItem]] = [:]

        for match in allMatches {
            guard let sport = sportsMap[match.sportId] else { continue }
            let competition = competitionsMap[match.competitionId]
            let item = createDisplayItem(from: match, sport: sport, competition: competition)
            grouped[match.sportId, default: []].append(item)
        }
        
        matchesBySport = grouped
    }

    private func createDisplayItem(
        from match: Match,
        sport: Sport,
        competition: Competition?
    ) -> MatchDisplayItem {

        MatchDisplayItem(
            id: match.id,
            name: "\(match.homeTeam) vs \(match.awayTeam)",
            startTime: match.date,
            status: match.status,
            currentTime: match.currentTime,
            result: match.result,
            homeTeamAvatarUrl: match.homeTeamAvatarURL,
            awayTeamAvatarUrl: match.awayTeamAvatarURL,
            sportId: match.sportId,
            competitionName: competition?.name ?? "Unknown League",
            competitionIcon: competition?.iconURL,
            sportName: sport.name,
            sportIconUrl: sport.iconURL
        )
    }

    // MARK: - State Logic

    private func updateViewState(isInitial: Bool) {
        if !isInitial {
            viewState = hasLoadedAnyMatches ? .content : .loading
            return
        }
        viewState = hasLoadedAnyMatches ? .content : .empty
    }
}
