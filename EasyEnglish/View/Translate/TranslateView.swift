//
//  TranslateView.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/19/24.
//

import SwiftUI
import AVFoundation

struct TranslateView: View {
    
    @State private var previousText: String = ""
    @State private var audioPlayer: AVAudioPlayer?
    
    @StateObject private var viewModel = TranslateViewModel()
    
    var body: some View {

        ZStack {
            
            VStack(spacing: 0) {
                
                Rectangle()
                    .fill(.orange.opacity(0.05))
                    .overlay {
                        CustomTextEditor(text: $previousText, placeholder: "Enter some text")
                            .padding([.top, .horizontal], 25)
                            .padding(.bottom, 80)
                    }
                
                Rectangle()
                    .fill(.gray.opacity(0.5))
                    .frame(height: 1)
                
                Rectangle()
                    .fill(.white)
                    .overlay(alignment: .topLeading) {
                        Text(viewModel.output.translatedText)
                            .padding(.top, 80)
                            .padding(.horizontal, 35)
                    }
            }
            
            middleItemView()
            
        }
        .navigationTitle("Translate")
            
    }
    
    func middleItemView() -> some View {
        
        HStack {
            VStack {
                Text("한국어")
                    .foregroundStyle(.black)
                Button(action: {
                    viewModel.input.inputText.send(previousText) //
                }, label: {
                    Circle()
                        .fill(.blue)
                        .frame(width: 40, height: 40)
                        .overlay {
                            Image(systemName: "star")
                        }
                })
                .padding(.vertical, 10)
                .padding(.horizontal, 16)
                
                Text("English")
                    .foregroundStyle(.black)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            Button(action: {
//                let text = "안녕하세요! 이것은 Google TTS의 예시입니다."
//                fetchAudio(from: text)
                
                if !viewModel.output.translatedText.isEmpty {
                    viewModel.input.ttsButtonTap.send(viewModel.output.translatedText)
                }
            }, label: {
                Image(systemName: "speaker.wave.2")
                    .foregroundStyle(.black)
            })
            .padding(.top, 100)

        
        }
        .padding(.horizontal, 20)
        
    }
    
    func fetchAudio(from text: String) {
        let apiKey = "" // 여기에 생성한 API 키를 입력하세요.
        let urlString = "https://texttospeech.googleapis.com/v1/text:synthesize?key=\(apiKey)"
        
        guard let url = URL(string: urlString) else { return }

        let requestBody: [String: Any] = [
            
            "input": ["text": text],
            "voice": ["languageCode": "en-gb", "name": "en-GB-Standard-A"], // 원하는 음성 설정
            "audioConfig": ["audioEncoding": "MP3"]
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestBody) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            guard let data = data else {
                        print("수신된 데이터가 없습니다.")
                        return
                    }
                    
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        // 응답 JSON 로그
                        print("응답 JSON: \(json)")
                        
                        if let audioContent = json["audioContent"] as? String,
                           let audioData = Data(base64Encoded: audioContent) {
                            print("오디오 콘텐츠를 수신했습니다. 오디오를 재생합니다...") // 오디오 콘텐츠 수신 로그
                            playAudio(data: audioData)
                        } else {
                            print("응답에서 오디오 콘텐츠를 찾을 수 없습니다.")
                        }
                    } else {
                        print("JSON 응답 파싱 중 오류가 발생했습니다.")
                    }
                }
                
                task.resume()
            }
    func playAudio(data: Data) {
        do {
            audioPlayer = try AVAudioPlayer(data: data)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("Audio playback error: \(error.localizedDescription)")
        }
    }

}

#Preview {
    TranslateView()
}
