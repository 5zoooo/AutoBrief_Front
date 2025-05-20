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
    @EnvironmentObject var viewModel: UploadViewModel
    
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
                    if viewModel.selectedTemplate != "" {
                        pathManager.path.append(.FileType)
                    }
                }, isActive: viewModel.selectedTemplate != "", btnColor: Color.first)
                .padding(.bottom, 80)
                
            }.padding(.horizontal, 40)
            .background(Color.mainBG)
            
            
            .navigationBarBackButtonHidden()
        }
    }
}
// MARK: Function
extension TemplateView {
    private func mapTemplateHeaderToCode(_ title: String) -> String {
        switch title {
        case "강의노트": return "lecture_note"
        case "회의록": return "meeting_minutes"
        case "진단서": return "ward_round"
        case "보고서": return "report"
        default: return ""
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
                        let selectedTitle = templatesList[index].header
                        let mapped = mapTemplateHeaderToCode(selectedTitle)
                        viewModel.setSelectedTemplate(mapped)
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
