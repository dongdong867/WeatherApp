//
//  SplineImage.swift
//  Weather
//
//  Created by Dong on 2024/4/14.
//

import SwiftUI
import SplineRuntime

struct SplineImage: View {
    let url: URL
    
    var body: some View {
        try? SplineView(sceneFileURL: url)
            .ignoresSafeArea(.all)
    }
}
