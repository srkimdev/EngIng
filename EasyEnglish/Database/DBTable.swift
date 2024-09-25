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
    @Persisted var categoryName: String = ""
    @Persisted var categoryDescription = ""
    @Persisted var chapters = List<ChapterTable>()
}

final class ChapterTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var chapterName: String = ""
    @Persisted var sentences = List<SentenceTable>()
}

final class SentenceTable: Object {
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
    @Persisted var image: String // ??
    
    convenience init(title: String = "", content: String = "", date: Date = Date(), image: String = "") {
        self.init()
        self.title = title
        self.content = content
        self.date = date
        self.image = image
    }
}

