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

final class ChapterTable: Object {
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

//MARK: Show a week
final class WeekAttendance: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var weekStartDate: Date
    @Persisted var days: List<DayAttendance>
}

final class DayAttendance: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var dayName: String
    @Persisted var date: Date
    @Persisted var isAttended: Bool
}

