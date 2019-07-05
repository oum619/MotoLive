//
//  DBManager.swift
//  MotoLive
//
//  Created by Motomi Ota on 2019/07/05.
//  Copyright © 2019 Motomi Ota. All rights reserved.
//

import Foundation

import RealmSwift

class DBManager{
  
  static let dbVersion:UInt64 = 1
  var db: Realm!
  
  init(){
    var config = Realm.Configuration()
    config.schemaVersion = DBManager.dbVersion
    config.migrationBlock = { migration, oldSchemaVersion in
      if oldSchemaVersion < DBManager.dbVersion {
        //migrate DB
      }
    }
    db = try! Realm(configuration: config)
  }
}
