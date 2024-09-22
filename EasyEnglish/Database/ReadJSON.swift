//
//  ReadJSON.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/22/24.
//

import Foundation

struct SentenceData: Decodable {
    let korean: String
    let english: String
}

struct ChapterData: Decodable {
    let chapterName: String
    let sentences: [SentenceData]
}

struct CategoryData: Decodable {
    let categoryName: String
    let chapters: [ChapterData]
}

//func loadSentenceData() -> [String: ]


