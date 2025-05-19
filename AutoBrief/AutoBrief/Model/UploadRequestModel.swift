//
//  UploadRequestModel.swift
//  AutoBrief
//
//  Created by 김다빈 on 5/19/25.
//

import Foundation

enum FileType: String, CaseIterable, Identifiable {
    case docs = "DOCX"
    case pdf = "PDF"
    case txt = "TXT"
    
    var id: String { self.rawValue }
}


struct UploadRequestModel {
    var audioData: Data
    var fileName: String
    var template: String
    var fileType: FileType

}
