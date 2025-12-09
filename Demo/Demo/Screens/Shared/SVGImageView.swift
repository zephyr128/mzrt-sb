//
//  SVGImageView.swift
//  Demo
//
//  Created by Nenad Prahovljanovic on 9. 12. 2025..
//

import SwiftUI
import SDWebImageSwiftUI

struct SVGImageView: View {
    var url: URL
    
    var body: some View {
        WebImage(url: url, options: [.scaleDownLargeImages]) { image in
            image
                .resizable()
        } placeholder: {
            ProgressView()
        }
        .indicator(.activity)
        .transition(.fade(duration: 0.3))
        .scaledToFit()
        .frame(alignment: .center)
    }
}
