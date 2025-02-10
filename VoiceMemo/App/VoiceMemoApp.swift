//
//  VoiceMemoApp.swift
//  VoiceMemo
//
//  Created by Gayoung Kim on 11/25/24.
//

import SwiftUI

@main
struct VoiceMemoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            OnboardingView()
        }
    }
}
