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
    @Published var selectedFileType: String = ""
    @Published var selectedTemplate: String = ""
    @Published var audioFileName: String = ""
    
    func setRecordedAudio(_ data: Data, audiofileName: String) {
        self.audioData = data
        self.audioFileName = fileName
    }
    
    func setAudioData(_ data: Data, fileName: String) {
          self.audioData = data
        self.audioFileName = fileName
      }
    func setFileName(_ name: String) {
        self.fileName = name
    }
    
    func setSelectedFileType(_ fileType: String) {
        self.selectedFileType = fileType
    }
    
    func setSelectedTemplate(_ template: String) {
        self.selectedTemplate = template
    }
    
    func resetClass() {
        audioData = nil
        fileName = ""
        selectedFileType = ""
        selectedTemplate = ""
        audioFileName = ""
    }
    
    func createUploadRequest() -> UploadRequestModel? {
        guard let audio = audioData else { return nil }
        print(self.audioData, self.fileName, self.selectedTemplate, self.selectedFileType)
        return UploadRequestModel(
            audioData: audio,
            fileName: fileName,
            template: selectedTemplate,
            fileType: selectedFileType
        )
    }
    
}
