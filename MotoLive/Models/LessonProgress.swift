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
  @objc dynamic var videoURL: String = ""
  @objc dynamic var progress: Float = 0 // video progress in seconds
  @objc dynamic var completed: Bool = false // video was watched to the end
  
  override static func primaryKey() -> String? {
    return "videoURL"
  }
  
  convenience init(lessonId: String) {
    self.init()
    self.videoURL = lessonId
  }
}
