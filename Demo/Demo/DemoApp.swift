//
//  DemoApp.swift
//  Demo
//
//  Created by Nenad Prahovljanovic on 5. 12. 2025..
//

import SwiftUI
import SDWebImage
import SDWebImageSVGCoder

@main
struct DemoApp: App {
    
    let dependencies = AppDependencies()
    
    init () {
        SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
    }
    
    var body: some Scene {
        WindowGroup {
            MatchHomeScreen(viewModel: dependencies.makeMatchListViewModel())
        }
    }
}
