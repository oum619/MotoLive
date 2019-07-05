//
//  LessonsViewManager.swift
//  MotoLive
//
//  Created by Motomi Ota on 2019/07/03.
//  Copyright © 2019 Motomi Ota. All rights reserved.
//

import Foundation
import RealmSwift
class LessonViewManager : DBManager{
  
  private let apiClient: APIClient!
  
  init(apiClient: APIClient) {
    self.apiClient = apiClient
  }
  
  func getLessons(_ completion: @escaping ((Result<[Lesson]>) -> Void)) {
    apiClient.getLessons { (result) in
      switch result {
      case .success(let data):
        do {
          let lessons = try JSONDecoder().decode([Lesson].self, from: data)
          DispatchQueue.main.async {
            try! self.db.write() {
              self.db.add(lessons)
            }
          }
          completion(.success(lessons))
        } catch {
          completion(.failure(error))
        }
      case .failure(let error):
        DispatchQueue.main.async {
          let storedLessons = self.db.objects(Lesson.self)
          if storedLessons.count > 0{
            var backup : [Lesson] = []
            for result in storedLessons{
              backup.append(result)
            }
            completion(.success(backup))
          }
          completion(.failure(error))
        }        
      }
    }
  }
}
