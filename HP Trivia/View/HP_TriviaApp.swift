//
//  HP_TriviaApp.swift
//  HP Trivia
//
//  Created by Станислав Леонов on 01.09.2025.
//

import SwiftUI

@main
struct HP_TriviaApp: App {
    @StateObject private var store = Store()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
