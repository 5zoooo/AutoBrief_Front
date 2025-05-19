//
//  AudioInput.swift
//  AutoBrief
//
//  Created by 김다빈 on 5/19/25.
//

import Foundation
import AVFoundation

class AudioRecorder: NSObject, ObservableObject {
    @Published var isRecording = false
    private var audioRecorder: AVAudioRecorder?
    private var recordedURL: URL?

    func startRecording() {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker])
            try session.setActive(true)

            let tempDir = FileManager.default.temporaryDirectory
            let fileName = "recording_\(Date().timeIntervalSince1970).m4a"
            let fileURL = tempDir.appendingPathComponent(fileName)

            let settings: [String: Any] = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 12000,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]

            audioRecorder = try AVAudioRecorder(url: fileURL, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.record()

            isRecording = true
            recordedURL = fileURL
        } catch {
            print("녹음 시작 실패: \(error.localizedDescription)")
        }
    }

    func stopRecording(completion: @escaping (Data?, String?) -> Void) {
        audioRecorder?.stop()
        isRecording = false

        guard let url = recordedURL else {
            completion(nil, nil)
            return
        }

        do {
            let data = try Data(contentsOf: url)
            completion(data, url.lastPathComponent)
        } catch {
            print("녹음 파일 읽기 실패: \(error.localizedDescription)")
            completion(nil, nil)
        }
    }
}

extension AudioRecorder: AVAudioRecorderDelegate {}
