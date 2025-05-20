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
    @StateObject var downloadViewModel = DownloadViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(downloadViewModel)
                .environmentObject(pathManager)
                .environmentObject(uploadViewModel)
        }
    }
}
