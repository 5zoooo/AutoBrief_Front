//
//  HomeView.swift
//  AutoBrief
//
//  Created by 김다빈 on 5/19/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var pathManager: PathManager

    let sampleDocumentCards: [DocumentCard] = [
        DocumentCard(
            title: "5월 마케팅 전략 회의",
            category: "회의록",
            date: "2025.05.17",
            durationInMinutes: 32,
            fileFormat: "Docx"
        ),
        DocumentCard(
            title: "고객 피드백 회의",
            category: "고객관리",
            date: "2025.04.29",
            durationInMinutes: 18,
            fileFormat: "Pdf"
        ),
        DocumentCard(
            title: "4월 월간 리포트 작성",
            category: "보고서",
            date: "2025.04.01",
            durationInMinutes: 25,
            fileFormat: "Docx"
        ),
        DocumentCard(
            title: "제품 기획 아이디어",
            category: "브레인스토밍",
            date: "2025.03.21",
            durationInMinutes: 14,
            fileFormat: "Txt"
        ),
        DocumentCard(
            title: "팀 회고 미팅",
            category: "내부 회의",
            date: "2025.02.11",
            durationInMinutes: 45,
            fileFormat: "Docx"
        ),
        DocumentCard(
            title: "CS 이슈 정리 회의",
            category: "고객지원",
            date: "2025.05.09",
            durationInMinutes: 27,
            fileFormat: "Pdf"
        ),
        DocumentCard(
            title: "재무 분석 발표 준비",
            category: "재무",
            date: "2025.01.19",
            durationInMinutes: 31,
            fileFormat: "Excel"
        ),
        DocumentCard(
            title: "경영진 공유 자료 브리핑",
            category: "임원 보고",
            date: "2025.05.01",
            durationInMinutes: 22,
            fileFormat: "Docx"
        )
    ]
    
    
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
                    
                    middleAreaHeader()
                        .padding(.top, 120)
                    
                    documentCardGrid
                        .padding(.top, 40)
                }
                .padding(.horizontal, 40)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(Color.mainBG)
            .navigationDestination(for: StackViewType.self) { StackViewType in
                switch StackViewType {
                case.Record:
                    RecordView().environmentObject(pathManager)
                case.Upload:
                    UploadView()
                case .Template:
                    TemplateView()
                case .FileType:
                    FileTypeView()
                case .Loading:
                    LoadingView()
                case .Result:
                    ResultView()
                }
            }

            
            
        }
        .background(Color.mainBG)
      
    }
}

//MARK: Views

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
            navigateBtn(btnHeadr: "녹음 시작", btnDescription: "새로운 녹음을 시작", btnmainColor: Color.first, clipColor: Color.btnbg1, clipSymbol: "microphone", customAction: {
                pathManager.path.append(.Record)
                print(pathManager.$path)
            })
            
            navigateBtn(btnHeadr: "파일 업로드", btnDescription: "오디오 파일 업로드", btnmainColor: Color.second, clipColor: Color.btnbg2, clipSymbol: "square.and.arrow.up", customAction: {
                pathManager.path.append(.Upload)
            })
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
    
    private func middleAreaHeader() -> some View {
        HStack(spacing: 0) {
            Text("최근 작업")
                .font(.title1())
                .foregroundStyle(.mainBlack)
            
            Spacer()
            
            Text("모두 보기")
                .font(.body2Bold())
                .foregroundStyle(Color.first)
            
        }
        
    }
    
    private var documentCardGrid: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 2), spacing: 20) {
                ForEach(sampleDocumentCards, id: \.title) { data in
                    documentCard(data: data)
                        .padding()
                        .frame(maxWidth: .infinity, minHeight: 148)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
                }
            }
        }
    }
    
    private func documentCard(data: DocumentCard) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(data.title)
                    .font(.title2())
                    .foregroundStyle(.mainBlack)
                
                Spacer()
                
                Text(data.fileFormat)
                    .font(.body1Regular())
                    .foregroundStyle(.gray1)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color(.systemGray6))
                    .cornerRadius(15)
            }
            
            HStack(spacing: 0) {
                Text("\(data.durationInMinutes)분 녹음")
                    .font(.body1Regular())
                    .foregroundStyle(Color.gray1)
                Text("|")
                    .font(.body1Regular())
                    .foregroundColor(Color.gray1)
                Text(data.date)
                    .font(.body1Regular())
                    .foregroundColor(Color.gray1)
                
            }
            
            HStack(spacing: 0) {
                Text("\(data.durationInMinutes)분 녹음")
                    .font(.body2Regular())
                    .foregroundColor(.mainBlack)
                
                Spacer()
                
                HStack(spacing: 10) {
                    
                    if data.isShared {
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                            .padding(EdgeInsets(top: 6, leading: 6, bottom: 6, trailing: 6))
                            .background(Circle().fill(Color.mainBG))
                        
                    }
                    
                    if data.hasCollaborator {
                        Image(systemName: "person.2.fill")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                            .padding(EdgeInsets(top: 6, leading: 6, bottom: 6, trailing: 6))
                            .background(Circle().fill(Color.mainBG))
                        
                    }
                }
                
            }
            .padding(.top, 35)
            
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        
        
        
        
    }
}

//#Preview {
//    HomeView()
//}

