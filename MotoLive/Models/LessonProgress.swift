//
//  LessonProgress.swift
//  MotoLive
//
//  Created by Motomi Ota on 2019/07/05.
//  Copyright © 2019 Motomi Ota. All rights reserved.
//

import Foundation
import RealmSwift

class LessonProgress : Object{
  @objc dynamic var lessonId: Int = 0
  @objc dynamic var progress: Float = 0 // video progress in seconds
  
  override static func primaryKey() -> String? {
    return "lessonId"
  }
  
  convenience init(lessonId: Int) {
    self.init()
    self.lessonId = lessonId
  }
}
