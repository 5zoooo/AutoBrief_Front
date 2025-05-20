//
//  ResultViewModel.swift
//  AutoBrief
//
//  Created by 김다빈 on 5/20/25.
//

// ResultViewModel.swift
import Foundation
import QuickLook

class ResultViewModel: NSObject, ObservableObject, QLPreviewControllerDataSource {
    @Published var downloadURL: URL? = nil
    @Published var isReadyToPreview: Bool = false

    func downloadFile(from urlString: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(false)
            return
        }

        let fileName = url.lastPathComponent
        let destinationURL = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)

        if FileManager.default.fileExists(atPath: destinationURL.path) {
            DispatchQueue.main.async {
                self.downloadURL = destinationURL
                self.isReadyToPreview = true
                completion(true)
            }
            return
        }

        URLSession.shared.downloadTask(with: url) { tempURL, _, error in
            guard let tempURL = tempURL, error == nil else {
                DispatchQueue.main.async { completion(false) }
                return
            }

            do {
                try FileManager.default.moveItem(at: tempURL, to: destinationURL)
                DispatchQueue.main.async {
                    self.downloadURL = destinationURL
                    self.isReadyToPreview = true
                    completion(true)
                }
            } catch {
                print("File move error: \(error)")
                DispatchQueue.main.async { completion(false) }
            }
        }.resume()
    }

    // MARK: - QLPreviewControllerDataSource
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return downloadURL == nil ? 0 : 1
    }

    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return downloadURL! as NSURL
    }
}
