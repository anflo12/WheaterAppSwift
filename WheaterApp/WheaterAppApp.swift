//
//  WheaterAppApp.swift
//  WheaterApp
//
//  Created by Andrés Flórez on 15/12/21.
//

import SwiftUI

@main
struct WheaterAppApp: App {
    @StateObject var viewModel:WheaterViewModel = WheaterViewModel()

    var body: some Scene {
        WindowGroup {
            HomePage()
                .environmentObject(viewModel)
                
           
        }
    }
}
