//
//  DBTable.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/22/24.
//

import Foundation
import RealmSwift

final class DBTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var category: String
    @Persisted var chapters = RealmSwift.List<Chapter>()
}

final class Chapter: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var number: Int = 1
    @Persisted var sentences = RealmSwift.List<Sentence>()
}

final class Sentence: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var korean: String = ""
    @Persisted var english: String = ""
}
