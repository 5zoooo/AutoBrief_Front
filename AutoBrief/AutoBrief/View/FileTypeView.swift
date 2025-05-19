//
//  FileTypeView.swift
//  AutoBrief
//
//  Created by 김다빈 on 5/19/25.
//

import SwiftUI

struct FileTypeView: View {
    @EnvironmentObject var pathManager: PathManager
    @State private var fileName: String = ""
    @State private var isActive = true
    @State private var selectedIndex: Int? = nil
    var body: some View {
        VStack(spacing: 0) {
            CustomHeader(action: {
                pathManager.path.removeLast()
            }, title: "파일 형식 선택")
            
            VStack(spacing: 80) {
                
                inputTextArea
                    .padding(.top, 128)
                    .padding(.horizontal, 40)
                
                documentArea
                    .padding(.horizontal, 40)
                
                Spacer()
                
                CTABtn1(action: {
                    pathManager.path.append(.Loading)
                }, isActive: true, btnColor: Color.first)
                .padding(.horizontal, 40)
                .padding(.bottom, 80)
            }
            .background(Color.mainBG)
            
        }
   
        .navigationBarBackButtonHidden()
    }
}


// MARK: Views
extension FileTypeView {
    private var inputTextArea: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("파일 이름")
                .font(.body1Bold())
                .foregroundStyle(.gray1)

            TextField("파일 이름을 입력하세요", text: $fileName)
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.1)) // 연한 배경색
                )
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.mainWhite) // 바깥 전체 카드처럼 보이게
        )
    }
    
    private func documentCard(data: DocumentTypeModel, isSelected: Bool) -> some View {
        HStack(spacing: 15) {
            ZStack {
                Circle()
                    .fill(data.tipsBgColor)
                    .frame(width: 80, height: 80)

                Image(systemName: data.tipsImageName)
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundStyle(data.tipsIconColor)
            }
            .padding(.leading, 20)
            
            VStack(alignment: .leading) {
                Text(data.header)
                    .multilineTextAlignment(.leading)
                    .font(.title2())
                    .foregroundStyle(Color.mainBlack)
                Text(data.discription)
                    .font(.body2Regular())
                    .foregroundStyle(Color.mainBlack)
             
            }
        
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 120)
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
    
    private var documentArea: some View {
        VStack(spacing: 20) {
            ForEach(documentTypeList.indices, id: \.self) { index in
                documentCard(data: documentTypeList[index], isSelected: selectedIndex == index)
                    .onTapGesture {
                        selectedIndex = index
                    }
            }
        }
    }
}

#Preview {
    FileTypeView()
}
