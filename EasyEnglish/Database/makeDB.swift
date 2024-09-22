//
//  makeDB.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/22/24.
//

import Foundation
import RealmSwift

func addInitialDataToRealm() {
    
    let realm = try! Realm()
    
//    let sentenceData =
    
    for
    
}

let sentenceData: [String: [(korean: String, english: String)]] = [
    "Daily Life": [
        ("안녕하세요", "Hello"),
        ("오늘 날씨가 좋네요", "The weather is nice today")
    ],
    "Travel": [
        ("여행을 가고 싶어요", "I want to go on a trip"),
        ("어디로 가는 게 좋을까요?", "Where should I go?")
    ]
]
