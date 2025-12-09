//
//  StateViews.swift
//  Demo
//
//  Created by Nenad Prahovljanovic on 8. 12. 2025..
//
import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView("Učitavanje podataka...").padding()
    }
}

struct EmptyStateView: View {
    let title: String
    let message: String
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "sportscourt")
                .font(.title)
                .foregroundColor(.gray)
            Text(title).font(.headline)
            Text(message).font(.subheadline).foregroundColor(.gray).multilineTextAlignment(.center)
        }
        .padding(40)
    }
}

struct ErrorStateView: View {
    let message: String
    let retryAction: () -> Void
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "wifi.slash")
                .font(.system(size: 50))
                .foregroundColor(.red)
            Text("Greška: Nema konekcije ili server nije dostupan.")
                .multilineTextAlignment(.center)
            Text(message).font(.caption).foregroundColor(.secondary)
            Button("Pokušaj ponovo", action: retryAction)
                .buttonStyle(.borderedProminent)
        }
        .padding(40)
    }
}
