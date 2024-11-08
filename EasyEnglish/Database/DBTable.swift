//
//  DBTable.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/22/24.
//

import Foundation
import RealmSwift

//MARK: Problem
final class CategoryTable: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var categoryName: String = "Movie & Drama"
    @Persisted var categoryDescription = ""
    @Persisted var chapters = List<ChapterTable>()
}

final class ChapterTable: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var chapterName: String = ""
    @Persisted var star: Bool = false
    @Persisted var progress: Double = 0
    @Persisted var sentences = List<SentenceTable>()
}

final class SentenceTable: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var korean: String = ""
    @Persisted var english: String = ""
    @Persisted var isCheck: Bool = false
    @Persisted var isLike: Bool = false
    @Persisted var whenSolved: String = ""
}

//MARK: Diary
final class DiaryTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var content: String
    @Persisted var date: Date
    @Persisted var image: Data
    
    convenience init(title: String, content: String, date: Date = Date()) {
        self.init()
        self.title = title
        self.content = content
        self.date = date
    }
}

//MARK: DayCheck
final class DayTable: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var date: Date
    @Persisted var day: String
    @Persisted var isAttended: Bool
    @Persisted var solveCount: Int
}

