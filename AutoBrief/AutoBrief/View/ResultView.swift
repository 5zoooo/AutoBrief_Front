//
//  ResultView.swift
//  AutoBrief
//
//  Created by 김다빈 on 5/19/25.
//

import SwiftUI

struct ResultView: View {
    @EnvironmentObject var pathManager: PathManager
    var body: some View {
        VStack(spacing: 0) {
            CustomHeader(action: {
                pathManager.path.removeLast()
            }, title: "녹음")
            VStack(spacing: 0) {
                
            }
        }
    }
}


#Preview {
    ResultView()
}
