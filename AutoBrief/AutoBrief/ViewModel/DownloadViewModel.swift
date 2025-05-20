import Foundation
import Alamofire

class DownloadViewModel: ObservableObject {
    @Published var downloadedFileURL: URL? = nil
    @Published var savedFilename: String? = nil
    @Published var isDownloading: Bool = false
    @Published var errorMessage: String? = nil

    func downloadDocument(documentId: Int, completion: @escaping (Bool) -> Void) {
        isDownloading = true
        errorMessage = nil

        let baseURL = "http://0.0.0.0:8000"
        let fileFormat = "pdf"
        
        let urlString = "\(baseURL)/api/v1/download/1?file_format=\(fileFormat)"

        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                self.errorMessage = "잘못된 URL입니다."
                self.isDownloading = false
                completion(false)
            }
            return
        }

        let destination: DownloadRequest.Destination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let randomFilename = UUID().uuidString + ".pdf" // ✅ 고정 확장자
            let fileURL = documentsURL.appendingPathComponent(randomFilename)

            if FileManager.default.fileExists(atPath: fileURL.path) {
                try? FileManager.default.removeItem(at: fileURL)
            }

            self.savedFilename = randomFilename
            self.downloadedFileURL = fileURL

            print("📄 PDF 저장 경로: \(fileURL)")
            return (fileURL, [.createIntermediateDirectories])
        }

        AF.download(url, to: destination)
            .validate()
            .response { response in
                DispatchQueue.main.async {
                    self.isDownloading = false

                    switch response.result {
                    case .success:
                        print("✅ PDF 다운로드 성공")
                        completion(true)
                    case .failure(let error):
                        self.errorMessage = "다운로드 실패: \(error.localizedDescription)"
                        print("❌ 다운로드 오류: \(error.localizedDescription)")
                        completion(false)
                    }
                }
            }
    }
}
