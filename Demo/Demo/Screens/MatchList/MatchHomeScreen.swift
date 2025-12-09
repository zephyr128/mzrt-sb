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
        VStack {
            Group {
                switch viewModel.viewState {
                case .loading:
                    LoadingView()
                case .content:
                    SportCategoryPager()
                        .environmentObject(viewModel)
                case .empty:
                    EmptyStateView(title: "Nema dostupnih mečeva",
                                   message: "Proverite kasnije ili se povežite na internet.")
                case .error(let message):
                    ErrorStateView(message: message, retryAction: viewModel.loadData)
                }
            }.transition(.opacity.animation(.smooth))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 28/255, green: 31/255, blue: 33/255))
        .preferredColorScheme(.dark)
        .onAppear { viewModel.loadData() }
    }
}

struct SportCategoryPager: View {
    @EnvironmentObject var viewModel: MatchListViewModel
    
    @State var selectedSportId: Int? = 1

    var body: some View {
        VStack(spacing: 8) {
            SportCategorySelector(availableSports: viewModel.availableSports, selectedSportId: $selectedSportId)
                .frame(height: 40)
            
            TabView(selection: $selectedSportId) {
                ForEach(viewModel.availableSports, id: \.id) { sport in
                    SportMatchesList(matches: viewModel.matchesBySport[sport.id] ?? [])
                        .tag(sport.id)
                }
            }
            .animation(.easeInOut(duration: 0.2), value: selectedSportId)
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .padding(.top, 24)
        .ignoresSafeArea(edges: .bottom)
        .onChange(of: viewModel.availableSports) { old, new in
            if selectedSportId == nil {
                selectedSportId = new.first?.id
            }
        }
    }
}
