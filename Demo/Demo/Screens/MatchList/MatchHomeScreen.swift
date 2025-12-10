//
//  MatchListView.swift
//  Demo
//
//  Created by Nenad Prahovljanovic on 5. 12. 2025..
//

import SwiftUI

struct MatchHomeScreen: View {
    @StateObject var viewModel: MatchListViewModel
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            content
                .transition(.opacity)
        }
        .preferredColorScheme(.dark)
        .onAppear {
            viewModel.loadData()
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.viewState {
        case .loading:
            LoadingView()
        case .content:
            SportCategoryPager()
                .environmentObject(viewModel)
        case .empty:
            EmptyStateView(
                title: "Nema dostupnih mečeva",
                message: "Proverite kasnije ili se povežite na internet."
            )
        case .error(let message):
            ErrorStateView(message: message, retryAction: viewModel.loadData)
        }
    }
}

// MARK: - SportCategoryPager

struct SportCategoryPager: View {
    @EnvironmentObject var viewModel: MatchListViewModel
    @State private var selectedSportId: Int?

    var body: some View {
        VStack(spacing: 8) {
            SportCategorySelector(
                availableSports: viewModel.availableSports,
                selectedSportId: $selectedSportId
            )
            .frame(height: 40)
            
            TabView(selection: $selectedSportId) {
                ForEach(viewModel.availableSports, id: \.id) { sport in
                    SportMatchesList(
                        matches: viewModel.matchesBySport[sport.id] ?? []
                    )
                    .tag(sport.id)
                }
            }
            .animation(.snappy, value: selectedSportId)
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .padding(.top, 24)
        .ignoresSafeArea(edges: .bottom)
        .onChange(of: viewModel.availableSports) { old, newSports in
            if selectedSportId == nil {
                selectedSportId = newSports.first?.id
            }
        }
        .onAppear {
            if selectedSportId == nil {
                selectedSportId = viewModel.availableSports.first?.id
            }
        }
    }
}
