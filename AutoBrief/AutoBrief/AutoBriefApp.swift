//
//  AutoBriefApp.swift
//  AutoBrief
//
//  Created by 김다빈 on 5/19/25.
//

import SwiftUI

@main
struct AutoBriefApp: App {
    @StateObject var pathManager = PathManager()
    @StateObject var uploadViewModel = UploadViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(pathManager)
                .environmentObject(uploadViewModel)
        }
    }
}
