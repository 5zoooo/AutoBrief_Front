//
//  ResultView.swift
//  AutoBrief
//
//  Created by 김다빈 on 5/19/25.
//

import SwiftUI
import UniformTypeIdentifiers

struct ResultView: View {
    @EnvironmentObject var pathManager: PathManager
    @EnvironmentObject var downloadViewModel: DownloadViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            CustomHeader(action: {
                pathManager.path.removeLast()
            }, title: "결과 보기")

            VStack(spacing: 20) {
                if let fileURL = downloadViewModel.downloadedFileURL {
                    Text("파일: \(fileURL.lastPathComponent)")
                        .font(.body)
                        .foregroundStyle(.gray)

                    QuickLookPreview(url: fileURL)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    Text("파일이 존재하지 않습니다.")
                        .foregroundStyle(.gray)
                        .padding()
                }
            }
            .padding()
        }
        .navigationBarBackButtonHidden()
        .background(Color.mainBG)
    }
}
