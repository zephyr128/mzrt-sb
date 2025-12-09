//
//  DemoApp.swift
//  Demo
//
//  Created by Nenad Prahovljanovic on 5. 12. 2025..
//

import SwiftUI

@main
struct DemoApp: App {
    
    let dependencies = AppDependencies()
    
    var body: some Scene {
        WindowGroup {
            MatchHomeScreen(viewModel: dependencies.makeMatchListViewModel())
        }
    }
}
