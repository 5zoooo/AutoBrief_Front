//
//  HomeView.swift
//  AutoBrief
//
//  Created by 김다빈 on 5/19/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var pathManager: PathManager
    var body: some View {
        NavigationStack(path: $pathManager.path) {
            
        }
    }
}

#Preview {
    HomeView()
}
