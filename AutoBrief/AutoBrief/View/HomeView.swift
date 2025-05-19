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
        VStack(alignment:.leading, spacing: 0) {
                MainViewHeader()
                topArea()
                    .padding(.top, 90)
                
            }
            
        }
        .navigationDestination(for: StackViewType.self) { StackViewType in
            switch StackViewType {
                
            default:
                RecordView()
            }
            
        }
    }
}

extension HomeView {
    private func topArea() -> some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("안녕하세요")
                .font(.title1())
                .foregroundStyle(.mainBlack)
            Text("Auto Brief로 음성을 텍스트로 변환하고 요약해 보세요")
                .font(.body1Regular())
                .foregroundStyle(.mainBlack)
        }
        
    }
}

//#Preview {
//    HomeView()
//}
