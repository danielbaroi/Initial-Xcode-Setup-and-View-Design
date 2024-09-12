//
//  Initial_Xcode_Setup_and_View_DesignApp.swift
//  Initial Xcode Setup and View Design
//
//  Created by Daniel Baroi on 9/11/24.
//

import SwiftUI

@main
struct YourApp: App {
    init() {
        // Customize Tab Bar appearance
        let appearance = UITabBarAppearance()
        
        // Set background color
        appearance.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 0.8, alpha: 1.0) // Your pastel yellow or tan color
        
        // Remove separator line by setting shadow color and shadow image to nil
        appearance.shadowColor = .clear
        appearance.shadowImage = nil

        // Apply appearance settings
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some Scene {
        WindowGroup {
            MenuView()
        }
    }
}
