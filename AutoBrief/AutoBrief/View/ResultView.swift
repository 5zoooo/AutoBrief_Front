//
//  ResultView.swift
//  AutoBrief
//
//  Created by 김다빈 on 5/19/25.
//

import SwiftUI

struct ResultView: View {
    @EnvironmentObject var pathManager: PathManager
    @EnvironmentObject var viewModel: UploadViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            CustomHeader(action: {
                pathManager.path.removeLast()
            }, title: "결과 보기")
            VStack(spacing: 0) {
                
            }
        }
    }
}

extension ResultView {
    
}

#Preview {
    ResultView()
}
