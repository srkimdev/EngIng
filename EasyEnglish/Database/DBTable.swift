//
//  DBTable.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/22/24.
//

import Foundation
import RealmSwift

//MARK: Problem
final class CategoryTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var categoryName: String = ""
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
    @Persisted var isLike: Bool = false
}

//MARK: Diary
final class DiaryTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var content: String
    @Persisted var date: Date
    @Persisted var image: String // ??
}




