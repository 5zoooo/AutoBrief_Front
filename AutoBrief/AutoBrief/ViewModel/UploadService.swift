import Alamofire
import Foundation

enum UploadError: Error {
    case server(message: String)
    case decodingError
    case unknown
}

struct UploadResponse: Decodable {
    let download_url: String
}

class UploadService {
    static func uploadAudio(
        request: UploadRequestModel,
        completion: @escaping (Result<UploadResponse, UploadError>) -> Void
    ) {
        let url = "http://0.0.0.0:8000/api/v1/generate-document" // 실제 API 주소로 교체

        AF.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(
                    request.audioData,
                    withName: "file",
                    fileName: "\(request.fileName).mpeg",  // 확장자 변경
                    mimeType: "audio/mpeg"
                )
                multipartFormData.append(Data(request.template.lowercased().utf8), withName: "template")
                multipartFormData.append(Data(request.fileType.lowercased().utf8), withName: "file_format")
                multipartFormData.append(Data(request.fileName.utf8), withName: "filename") // 확장자 없이
            },
            to: url,
            method: .post
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: UploadResponse.self) { response in
            switch response.result {
            case .success(let uploadResponse):
                completion(.success(uploadResponse))
            case .failure:
                if let data = response.data,
                   let errorDict = try? JSONDecoder().decode([String: String].self, from: data),
                   let errorMessage = errorDict["message"] {
                    completion(.failure(.server(message: errorMessage)))
                } else {
                    completion(.failure(.unknown))
                }
            }
        }
    }
}
