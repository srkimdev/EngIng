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
        let result = await NetworkManager.shared.requestAPI(router: Router.tts(query: query), type: TTSResponse.self)
        
        switch result {
        case .success(let value):
            DispatchQueue.main.async {
                print(value, "value")
                self.playSound(value.audioContent)
            }
        case .failure(let error):
            print(error)
        }
        
    }
    
    func playSound(_ mp3: String) {
        guard let url = Bundle.main.url(forResource: mp3, withExtension: "mp3") else {
            print("MP3 file not found.")
            return
        }

        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            player.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    
    
}
