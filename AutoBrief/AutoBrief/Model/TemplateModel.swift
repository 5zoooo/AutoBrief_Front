//
//  TemplateModel.swift
//  AutoBrief
//
//  Created by 김다빈 on 5/19/25.
//

import SwiftUI

struct TemplateModel {
    var tipsImageName: String
    var tipsBgColor: Color
    var tipsIconColor: Color
    var header: String
    var discription: String
}

let templatesList: [TemplateModel] = [
    TemplateModel(tipsImageName: "book", tipsBgColor: Color.greenBg, tipsIconColor: Color.green, header: "강의 노트", discription: "강의 내용을 구조화된 노트로"),
    TemplateModel(tipsImageName: "richtext.page", tipsBgColor: Color.redBtnBG, tipsIconColor: Color.first, header: "회의록", discription: "회의 내용을 체계적으로 정리"),
    TemplateModel(tipsImageName: "person", tipsBgColor: Color.yellowBtnBg, tipsIconColor: Color.second, header: "회진", discription: "회진 내용을 빠르게 작성해주는 보고서"),
    TemplateModel(tipsImageName: "document.on.document", tipsBgColor: Color.mainBG, tipsIconColor: Color.mainBlue, header: "보고서", discription: "데이터 분석을 포함한 보고서")
]


struct DocumentTypeModel {
    var tipsImageName: String
    var tipsBgColor: Color
    var tipsIconColor: Color
    var header: String
    var discription: String
}

let documentTypeList: [DocumentTypeModel] = [
    DocumentTypeModel(tipsImageName: "document.on.document", tipsBgColor: Color.mainBG, tipsIconColor: Color.mainBlue, header: "DOCX (Word)", discription: "Microsoft Word에서 편집 가능한 문서"),
    DocumentTypeModel(tipsImageName: "richtext.page", tipsBgColor: Color.redBtnBG, tipsIconColor: Color.first, header: "PDF", discription: "모든 기기에서 동일하게 보이는 문서"),
    DocumentTypeModel(tipsImageName: "text.page", tipsBgColor: Color.mainBG, tipsIconColor: Color.gray1, header: "TXT", discription: "가장 기본적인 텍스트 형식")
    
]
