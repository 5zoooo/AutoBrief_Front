//
//  StatusService.swift
//  AutoBrief
//
//  Created by 김다빈 on 5/20/25.
//

import Alamofire
import Foundation

enum StatusCheckError: Error {
    case server(message: String)
    case decodingError
    case unknown
}

class StatusService {
    static func checkDocumentStatus(
        id: String,
        completion: @escaping (Result<StatusResponse, StatusCheckError>) -> Void
    ) {
        let url = "https://your-server.com/api/v1/status/\(id)"  // 실제 URL로 변경

        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: StatusResponse.self) { response in
                switch response.result {
                case .success(let statusResponse):
                    completion(.success(statusResponse))
                case .failure:
                    if let data = response.data,
                       let errorResponse = try? JSONDecoder().decode(StatusErrorResponse.self, from: data) {
                        completion(.failure(.server(message: errorResponse.detail.message)))
                    } else {
                        completion(.failure(.unknown))
                    }
                }
            }
    }
}
