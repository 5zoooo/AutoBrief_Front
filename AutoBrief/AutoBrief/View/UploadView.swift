//
//  UploadView.swift
//  AutoBrief
//
//  Created by 김다빈 on 5/19/25.
//

import SwiftUI

struct UploadView: View {
    @State private var showAudioPicker = false
    @StateObject private var viewModel = UploadViewModel()
    @EnvironmentObject var pathManager: PathManager
    @State private var isPossible = true
    var body: some View {
        VStack(spacing: 0) {
            CustomHeader(action: {
                pathManager.path.removeLast()
            }, title: "파일 업로드")
            
            VStack(spacing: 80) {
                mainArea
                    .padding(.top, 180)
                
                HStack {
                    Spacer()
                    CTABtn2(action: {
                        if isPossible {
                            pathManager.path.append(.Template)
                        }
                    }, btnColor: Color.second, isActive: isPossible)
                }
            }
            .padding(.horizontal,40)
            .frame(maxHeight: .infinity, alignment: .top)
            .background(Color.mainBG)
            
            
        }
        .navigationBarBackButtonHidden()
    }
}


// MARK: EX+ View
extension UploadView {
    private var mainArea: some View {
        VStack(spacing: 0) {
            tipsImage()
                .padding(.top, 40)
            
            VStack(spacing: 5) {
                Text("오디오 파일을 업로드 해주세요")
                    .font(.title2())
                    .foregroundStyle(Color.mainBlack)
                Text("MP3, WAV, M4A 파일 (최대 500MB)")
                    .font(.body2Regular())
                    .foregroundStyle(Color.mainBlack)
            }
            .padding(.top, 30)
            
            Button {
                showAudioPicker = true
            } label: {
                Text("파일 선택")
                    .font(.title2())
                    .foregroundStyle(Color.mainWhite)
                    .padding(.vertical, 15)
                    .padding(.horizontal, 47)
                    .background(Color.second)
                    .cornerRadius(10)
            }
            .sheet(isPresented: $showAudioPicker) {
                AudioFilePicker { url in
                    do {
                        let data = try Data(contentsOf: url)
                        viewModel.setAudioData(data)
                    } catch {
                        print("파일 로딩 실패: \(error.localizedDescription)")
                    }
                }
            }
            .padding(EdgeInsets(top: 20, leading: 0, bottom: 40, trailing: 0))

        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.mainWhite)
            
        )
   
   

    }
    
    private func tipsImage() -> some View {
        ZStack {
            Circle()
                .fill(Color.btnbg2)
                .frame(width: 80, height: 80) // 원하는 사이즈 조정

            Image(systemName: "square.and.arrow.up")
                .font(.system(size: 30, weight: .semibold))
                .foregroundColor(.white)
        }
    }
}
#Preview {
    UploadView()
}
