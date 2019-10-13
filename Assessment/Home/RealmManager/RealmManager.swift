//
//  RealmManager.swift
//  Assessment
//
//  Created by Omika Garg on 11/10/19.
//  Copyright © 2019 Akshay Garg. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - Get realm classes object from realm.
extension Results {
    func toArray<T>(type: T.Type) -> [T] {
        return compactMap { $0 as? T }
    }
}

final class RealmManager {
    
    static let shared = RealmManager()
    var realm: Realm!
    
    private init() {
        realm = try? Realm()
    }
    
    var articles: Results<RealmArticle> {
        return realm.objects(RealmArticle.self)
    }
    
    
    /// Add object to Realm DB
    ///
    /// - Parameter object: RealmArticle
    func add(object: RealmArticle) {
        try! realm.write {
            realm.add(object)
        }
    }
    
    
    ///Delete all objects from the realm DB
    func delete() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    
    /// Get object from Realm DB
    ///
    /// - Returns: RealmArticle
    func getArticles() -> [RealmArticle] {
        let results: Results<RealmArticle> = realm.objects(RealmArticle.self)
        return results.toArray(type: RealmArticle.self) as [RealmArticle]
    }
}
