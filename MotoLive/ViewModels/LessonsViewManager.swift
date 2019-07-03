//
//  LessonsViewManager.swift
//  MotoLive
//
//  Created by Motomi Ota on 2019/07/03.
//  Copyright © 2019 Motomi Ota. All rights reserved.
//

import Foundation

class LessonViewManager {
  
  private let apiClient: APIClient!
  
  init(apiClient: APIClient) {
    self.apiClient = apiClient
  }
  
  func getLessons(_ completion: @escaping ((Result<[Lesson]>) -> Void)) {
    apiClient.getLessons { (result) in
      switch result {
      case .success(let data):
        do {
          let items = try JSONDecoder().decode([Lesson].self, from: data)
          completion(.success(items))
        } catch {
          completion(.failure(error))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}
