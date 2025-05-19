//
//  LoadingView.swift
//  AutoBrief
//
//  Created by 김다빈 on 5/19/25.
//

import SwiftUI

struct LoadingView: View {
    @EnvironmentObject var pathManager: PathManager
    var body: some View {
        VStack(alignment:.center, spacing: 10) {
            LottieView(fileName: "Animation LottieFiles", loopMode: .loop)
                .frame(width: 300, height: 300)
                .padding(.bottom, 40)
            Text("변환중입니다 잠시만 기다려 주세요.")
                .font(.title2())
                .padding(.bottom, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.mainBG)
        
    }
}

#Preview {
    LoadingView()
}
