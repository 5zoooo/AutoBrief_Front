//
//  RecordView.swift
//  AutoBrief
//
//  Created by 김다빈 on 5/19/25.
//

import SwiftUI

struct RecordView: View {
    @EnvironmentObject var pathManager: PathManager
    @EnvironmentObject var viewModel: UploadViewModel
    
    @State private var isPossible = true
    var body: some View {
        VStack(spacing: 0) {
            CustomHeader(action: {
                pathManager.path.removeLast()
            }, title: "녹음")
            .padding(.top, 20)
        
            VStack(spacing: 0) {
                mainArea
                    .padding(.top, 185)
                
                HStack {
                    Spacer()
                    CTABtn2(action: {
                        if isPossible {
                            pathManager.path.append(.Template)
                        }
                    }, btnColor: Color.first, isActive: isPossible)
                }
                .padding(.top, 110)
            }
            .padding(.horizontal,40)
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.bottom, 40)
            .background(Color.mainBG)
            
        }

        .navigationBarBackButtonHidden()
        
        
    }
}


// MARK: Views
extension RecordView {
    private func tipsBtn(customAction: @escaping () -> Void) -> some View{
        Button {
            customAction()
        } label: {
            ZStack {
                Circle()
                    .fill(Color.btnbg1)
                    .frame(width: 80, height: 80) // 원하는 사이즈 조정

                Image(systemName: "microphone")
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundColor(.white)
            }
        }

    }
    
    
    private var mainArea: some View {
        VStack(spacing: 0) {
            Text("녹음 준비됨")
                .font(.title1())
                .foregroundStyle(.gray1)
                .padding(.top, 20)
            
            VStack(spacing: 20) {
                tipsBtn {
                    print()
                }
                
                Text("버튼을 눌러 녹음을 시작하세요")
                    .font(.body1Regular())
                    .foregroundStyle(.gray1)
            }
            .padding(.top, 150)
            .padding(.bottom, 40)
        }.frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.mainWhite)
        )
    }
    
    
    
}
//#Preview {
//    RecordView()
//}
