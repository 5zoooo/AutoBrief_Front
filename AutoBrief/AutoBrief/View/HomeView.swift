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
            
            VStack(alignment: .leading, spacing: 0) {
                MainViewHeader()
                VStack(alignment:.leading, spacing: 0) {
     
                    VStack(alignment: .leading, spacing: 0){
                        topArea()
                    }.padding(.top, 90)
                    navigateArea
                        .padding(.top, 50)
                    
                }
                .padding(.horizontal, 40)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(Color.mainBG)
          
            
        }
        .background(Color.mainBG)
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
    
    private var navigateArea: some View {
        HStack(spacing: 20) {
            navigateBtn(btnHeadr: "녹음 시작", btnDescription: "새로운 녹음을 시작", btnmainColor: Color.first, clipColor: Color.btnbg1, clipSymbol: "microphone", customAction: {print()})
            
            navigateBtn(btnHeadr: "파일 업로드", btnDescription: "오디오 파일 업로드", btnmainColor: Color.second, clipColor: Color.btnbg2, clipSymbol: "square.and.arrow.up", customAction: {print()})
        }
        .frame(maxWidth: .infinity)
        .frame(height: 95)
    }
    
    
    
    private func navigateBtn (
        btnHeadr: String,
        btnDescription: String,
        btnmainColor: Color,
        clipColor: Color,
        clipSymbol: String,
        customAction: @escaping () -> Void
    ) -> some View {
        HStack(spacing: 0) {
            Button(action: {
                customAction()
            }, label: {
                HStack(spacing: 15) {
                    ZStack {
                        Circle()
                            .fill(clipColor)
                            .frame(width: 30, height: 30)
                        Image(systemName: clipSymbol)
                            .foregroundStyle(Color.mainWhite)
                            .font(.system(size: 12, weight: .semibold))
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text(btnHeadr)
                            .font(.title2())
                            .foregroundStyle(.mainWhite)
                        Text(btnDescription)
                            .font(.body1Regular())
                            .foregroundStyle(.mainWhite)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundStyle(Color.mainWhite)
                        .font(.system(size: 20, weight: .semibold))
                }
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(btnmainColor)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            })
        }
    }
}

//#Preview {
//    HomeView()
//}
