//
//  TranslateQuery.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/19/24.
//

import Foundation

struct TranslateQuery: Encodable {
    let text: [String]
    let target_lang: String
}
