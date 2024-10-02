//
//  TTSQuery.swift
//  EasyEnglish
//
//  Created by 김성률 on 10/2/24.
//

import Foundation

struct TTSInput: Codable {
    let input: TextInput
    let voice: VoiceSelectionParams
    let audioConfig: AudioConfig
}

struct TextInput: Codable {
    let text: String
}

struct VoiceSelectionParams: Codable {
    let languageCode: String = "en-US"
    let name: String = "en-US-Wavenet-D"
    let ssmlGender: String = "FEMALE"
}

struct AudioConfig: Codable {
    let audioEncoding: String = "MP3"
}
