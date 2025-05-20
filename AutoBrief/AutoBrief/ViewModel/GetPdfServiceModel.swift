//
//  GetPdfServiceModel.swift
//  AutoBrief
//
//  Created by 김다빈 on 5/20/25.
//

import Foundation
import Alamofire

enum DownloadError: Error {
    case server(message: String)
    case fileNotFound
    case invalidResponse
    case unknown
}

class DownloadService {
    static func downloadFile(
        id: String,
        fileFormat: String,
        completion: @escaping (Result<URL, DownloadError>) -> Void
    ) {
        let urlString = "https://your-server.com/api/v1/download/\(id)?file_format=\(fileFormat)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidResponse))
            return
        }

        let destination: DownloadRequest.Destination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileName = "AutoBrief_\(UUID().uuidString).\(fileFormat)"
            let fileURL = documentsURL.appendingPathComponent(fileName)
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }

        AF.download(url, to: destination)
            .validate(statusCode: 200..<300)
            .response { response in
                if let error = response.error {
                    if response.response?.statusCode == 404 {
                        completion(.failure(.fileNotFound))
                    } else {
                        print("다운로드 오류: \(error.localizedDescription)")
                        completion(.failure(.server(message: error.localizedDescription)))
                    }
                    return
                }

                guard let filePath = response.fileURL else {
                    completion(.failure(.unknown))
                    return
                }

                completion(.success(filePath))
            }
    }
}
