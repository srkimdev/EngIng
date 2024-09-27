//
//  RealmRepository.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/24/24.
//

import Foundation
import RealmSwift

final class RealmRepository<T: Object> {
    
    private let realm = try! Realm()
        
    //MARK: Create
    func createItem(_ data: T) {
        do {
            try realm.write {
                realm.add(data)
                print("Realm Create Succeed")
            }
        } catch {
            print("Realm Error")
        }
    }
    
    //MARK: Read All
    func readAllItem() -> Results<T> {
        let list = realm.objects(T.self)
        return list
    }
    
    //MARK: Update
    func updateItem(primaryKey: Any, with updates: (T) -> Void) {
        guard let objectToUpdate = realm.object(ofType: T.self, forPrimaryKey: primaryKey) else {
            print("Object not found for update")
            return
        }
        
        do {
            try realm.write {
                updates(objectToUpdate)
                print("Realm Update Succeed")
            }
        } catch {
            print("Realm Error during update")
        }
    }

    //MARK: Delete
    func deleteItem(primaryKey: Any) {
        if let objectToDelete = realm.object(ofType: T.self, forPrimaryKey: primaryKey) {
            do {
                try realm.write {
                    realm.delete(objectToDelete)
                    print("Realm Delete Succeed")
                }
            } catch {
                print("Realm Error")
            }
        } else {
            print("Object not found for deletion")
        }
    }

    //MARK: Detect Realm DB file URL
    func detectRealmURL() {
        print(realm.configuration.fileURL ?? "No Realm file URL found")
    }
    
}
