//
//  TranslateViewModel.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/19/24.
//

import Foundation
import Combine
import AVFoundation

final class TranslateViewModel: ObservableObject {
    
    var cancellables = Set<AnyCancellable>()
    var input = Input()
    @Published var output = Output()
    
    var audioPlayer: AVAudioPlayer?
    
    struct Input {
        let inputText = PassthroughSubject<String, Never>()
        let ttsButtonTap = PassthroughSubject<String, Never>()
    }

    struct Output {
        var translatedText: String = ""
        var ttsMP3: String = ""
    }
    
    init() {
        
        input.inputText
            .sink { value in
                Task {
                    await self.translate(text: value)
                }
            }
            .store(in: &cancellables)
        
        input.ttsButtonTap
            .sink { value in
                Task {
                    await self.tts(text: value)
                }
            }
            .store(in: &cancellables)
            
    }
    
    func translate(text: String) async {
        let query = TranslateQuery(text: [text], target_lang: "EN")
        let result = await NetworkManager.shared.requestAPI(router: Router.translate(query: query), type: TranslateResponse.self)
        
        switch result {
        case .success(let value):
            DispatchQueue.main.async {
                self.output.translatedText = value.translations.first?.text ?? ""
            }
        case .failure(let error):
            print(error)
        }
    }
    
    func tts(text: String) async {
        
        let input = TextInput(text: text)
        let voiceSelectionParams = VoiceSelectionParams()
        let audioConfig = AudioConfig()
        
        let query = TTSInput(input: input, voice: voiceSelectionParams, audioConfig: audioConfig)
        print(query, "query")
        let result = await NetworkManager.shared.requestAPI(router: Router.tts(query: query), type: TTSResponse.self)
        
        switch result {
        case .success(let response):
            if let audioData = Data(base64Encoded: response.audioContent) {
                playSound(data: audioData)
            }
        case .failure(let error):
            print(error)
        }
        
    }
    
    func playSound(data: Data) {
        do {
            audioPlayer = try AVAudioPlayer(data: data)
            audioPlayer?.play()
            
            print("오디오가 재생됩니다.")
        } catch let error {
            print("오디오 재생 중 오류 발생: \(error.localizedDescription)")
        }
    }
    
}
