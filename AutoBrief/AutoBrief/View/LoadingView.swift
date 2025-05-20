//
//  LoadingView.swift
//  AutoBrief
//
//  Created by 김다빈 on 5/19/25.
//

import SwiftUI

struct LoadingView: View {
    @EnvironmentObject var uploadViewModel: UploadViewModel
    @EnvironmentObject var downloadViewModel: DownloadViewModel
    @EnvironmentObject var pathManager: PathManager

    @State private var errorMessage: String? = nil

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            if let error = errorMessage {
                Text("❌ 변환 실패: \(error)")
                    .foregroundStyle(.red)
                    .padding()

                Button("이전으로 돌아가기") {
                    pathManager.path.removeLast()
                }
                .padding()
            } else {
                LottieView(fileName: "Animation LottieFiles", loopMode: .loop)
                    .frame(width: 300, height: 300)
                    .padding(.bottom, 40)

                Text("변환 중입니다.\n잠시만 기다려 주세요.")
                    .font(.title2())
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 40)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.mainBG)
        .onAppear {
            startProcessing()
        }
        .navigationBarBackButtonHidden()
    }

    private func startProcessing() {
        guard let request = uploadViewModel.createUploadRequest() else {
            self.errorMessage = "업로드 요청 생성에 실패했습니다."
            return
        }

        UploadService.uploadAudio(request: request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    // ✅ 업로드 성공 후 PDF 다운로드 (포맷은 내부에서 고정)
                    downloadViewModel.downloadDocument(documentId: 1) { success in
                        DispatchQueue.main.async {
                            if success {
                                pathManager.path.append(.Result)
                            } else {
                                self.errorMessage = downloadViewModel.errorMessage ?? "문서 다운로드에 실패했습니다."
                            }
                        }
                    }

                case .failure(let error):
                    switch error {
                    case .server(let msg):
                        self.errorMessage = msg
                    case .decodingError:
                        self.errorMessage = "응답 파싱 실패"
                    case .unknown:
                        self.errorMessage = "알 수 없는 오류 발생"
                    }
                }

                uploadViewModel.resetClass()
            }
        }
    }
}
