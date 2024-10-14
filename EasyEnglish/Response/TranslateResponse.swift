//
//  TranslateResponse.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/19/24.
//

import Foundation

struct TranslateResponse: Decodable {
    let translations: [Translation]
}

struct Translation: Decodable {
    let detected_source_language: String
    let text: String
}
