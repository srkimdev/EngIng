//
//  ReadJSON.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/22/24.
//

import Foundation
import RealmSwift

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

func loadJSONData() -> [CategoryData]? {
    guard let url = Bundle.main.url(forResource: "data", withExtension: "json") else {
        print("JSON file not found")
        return nil
    }

    do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let categories = try decoder.decode([CategoryData].self, from: data)
        return categories
    } catch {
        print("Error parsing JSON: \(error)")
        return nil
    }
}

func saveToRealm(categories: [CategoryData]) {
    let realm = try! Realm()
    print(realm.configuration.fileURL)

    for category in categories {
        let categoryObject = CategoryTable()
        categoryObject.categoryName = category.categoryName

        for chapter in category.chapters {
            let chapterObject = ChapterTable()
            chapterObject.chapterName = chapter.chapterName

            for sentence in chapter.sentences {
                let sentenceObject = SentenceTable()
                sentenceObject.korean = sentence.korean
                sentenceObject.english = sentence.english

                chapterObject.sentences.append(sentenceObject)
            }
            categoryObject.chapters.append(chapterObject)
        }

        try! realm.write {
            realm.add(categoryObject)
        }
    }
}

func checkFirstLaunch() {
    let userDefaults = UserDefaults.standard

    if userDefaults.bool(forKey: "isFirst") == false {
        if let categories = loadJSONData() {
            saveToRealm(categories: categories)
            userDefaults.set(true, forKey: "isFirst")
        }
    } else {
        print("Data has already been imported")
    }
}
