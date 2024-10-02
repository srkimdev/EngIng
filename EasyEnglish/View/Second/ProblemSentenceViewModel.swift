//
//  ProblemSentenceViewModel.swift
//  EasyEnglish
//
//  Created by 김성률 on 10/2/24.
//

import Foundation
import Combine
import AVFoundation

final class ProblemSentenceViewModel: ObservableObject {
    
    var cancellables = Set<AnyCancellable>()
    var audioPlayer: AVAudioPlayer?
    
    let input = Input()
    @Published
    var output = Output()
    
    struct Input {
        let answerButtonTap = PassthroughSubject<Void, Never>()
        let soundButtonTap = PassthroughSubject<String, Never>()
    }
    
    struct Output {
        var answerButtonStatus = false
    }
    
    init() {
        
        input.answerButtonTap
            .sink { value in
                self.output.answerButtonStatus.toggle()
            }
            .store(in: &cancellables)
        
        input.soundButtonTap
            .sink { value in
                Task {
                    await self.tts(text: value)
                }
            }
            .store(in: &cancellables)
        
    }
    
    private func tts(text: String) async {
        
        let input = TextInput(text: text)
        let voiceSelectionParams = VoiceSelectionParams()
        let audioConfig = AudioConfig()
        
        let query = TTSInput(input: input, voice: voiceSelectionParams, audioConfig: audioConfig)
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
    
    private func playSound(data: Data) {
        do {
            audioPlayer = try AVAudioPlayer(data: data)
            audioPlayer?.play()
            
            print("오디오가 재생됩니다.")
        } catch let error {
            print("오디오 재생 중 오류 발생: \(error.localizedDescription)")
        }
    }
    
    
}
