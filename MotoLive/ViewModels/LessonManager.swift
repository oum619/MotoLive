//
//  LessonsViewManager.swift
//  MotoLive
//
//  Created by Motomi Ota on 2019/07/03.
//  Copyright © 2019 Motomi Ota. All rights reserved.
//

import Foundation
import RealmSwift
class LessonManager : DBManager{
  
  static let shared = LessonManager()
  private lazy var apiClient = APIClient()
  
  func downloadLessons(_ completion: @escaping ((APIResult<Results<Lesson>>) -> Void)) {
    apiClient.getLessons { (result) in
      DispatchQueue.main.async {
        switch result {
        case .success(let lessons):
          try! self.db.write() {
            self.db.add(lessons, update: .modified)
          }
          completion(.success(self.getLessons()))
        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
  }
  
  func getLessons() -> Results<Lesson>{
     return db.objects(Lesson.self)
  }
  
  func getLessonsProgress() -> Results<LessonProgress>{
      return db.objects(LessonProgress.self)
  }
  
  func updateLessonProgress(_ lessonProgress:LessonProgress, seconds:Float){
    try! self.db.write() {
      lessonProgress.progress = seconds      
      self.db.add(lessonProgress, update: .modified)
    }
  }
  func updateLessonProgress(_ lessonProgress:LessonProgress, completed:Bool){
    try! self.db.write() {
      lessonProgress.completed = completed
      self.db.add(lessonProgress, update: .modified)
    }
  }
}
