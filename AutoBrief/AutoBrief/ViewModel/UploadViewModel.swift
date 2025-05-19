//
//  UploadViewModel.swift
//  AutoBrief
//
//  Created by 김다빈 on 5/19/25.
//

import Foundation

class UploadViewModel: ObservableObject {
    @Published var audioData: Data? = nil
    @Published var fileName: String = ""
    @Published var selectedFileType: FileType? = nil
    @Published var selectedTemplate: String = ""
    
    func setAudioData(_ data: Data) {
        self.audioData = data
    }
    
    func setFileName(_ name: String) {
        self.fileName = name
    }
    
    func setSelectedFileType(_ fileType: FileType) {
        self.selectedFileType = fileType
    }
    
    func setSelectedTemplate(_ template: String) {
        self.selectedTemplate = template
    }
    
    func createUploadRequest() -> UploadRequestModel? {
        guard let audio = audioData,
              let type = selectedFileType
        else { return nil }
        
        return UploadRequestModel(
            audioData: audio,
            fileName: fileName,
            template: selectedTemplate,
            fileType: type
        )
    }
    
}
