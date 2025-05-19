//
//  TemplateView.swift
//  AutoBrief
//
//  Created by 김다빈 on 5/19/25.
//

import SwiftUI

struct TemplateView: View {
    @State private var isActive = true
    @State private var selectedIndex: Int? = nil
    @EnvironmentObject var pathManager: PathManager
    var body: some View {
        VStack(spacing: 0) {
            CustomHeader(action: {
                pathManager.path.removeLast()
            }, title: "템플릿 선택")
            VStack {
                cardViewArea
                    .padding(.top, 150)
                
                Spacer()
                
                CTABtn1(action: {
                    pathManager.path.append(.FileType)
                }, isActive: true, btnColor: Color.first)
                .padding(.bottom, 80)
                
            }.padding(.horizontal, 40)
            .background(Color.mainBG)
            
            
            .navigationBarBackButtonHidden()
        }
    }
}


// MARK: Views
extension TemplateView {
    
    private var cardViewArea: some View {
        LazyVGrid(columns:
                    [GridItem(.flexible(), spacing: 20), GridItem(.flexible())],
                  spacing: 30) {
            ForEach(templatesList.indices, id: \.self) { index in
                templateCardView(templatesList[index], isSelected: selectedIndex == index)
                    .onTapGesture {
                        selectedIndex = index
                    }
            }
        }
    }
    
    private func templateCardView(_ data: TemplateModel, isSelected: Bool) -> some View {
        HStack(alignment: .center, spacing: 20) {
            // 아이콘 영역
            ZStack {
                Circle()
                    .fill(data.tipsBgColor)
                    .frame(width: 64, height: 64)

                Image(systemName: data.tipsImageName)
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundStyle(data.tipsIconColor)
            }

            // 텍스트 영역
            VStack(alignment: .leading, spacing: 5) {
                Text(data.header)
                    .font(.title1())
                    .foregroundStyle(Color.mainBlack)

                Text(data.discription)
                    .font(.body2Regular())
                    .foregroundStyle(Color.mainBlack)
            }

            Spacer()
        }
        .padding(20)
        .frame(maxWidth: .infinity, minHeight: 140)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.mainWhite)
                .shadow(color: Color.black.opacity(0.05), radius: 1, x: 0, y: 1)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isSelected ? Color.second : Color.clear, lineWidth: 2)
        )
    }
}
