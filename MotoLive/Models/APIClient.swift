//
//  APIClient.swift
//  MotoLive
//
//  Created by Motomi Ota on 2019/07/03.
//  Copyright © 2019 Motomi Ota. All rights reserved.
//

import Foundation

enum APIResult<T> {
  case success(T)
  case failure(Error)
}

enum APIError: Error {
  case noData
}

class APIClient {
  
  func getLessons(result: @escaping ((APIResult<[Lesson]>) -> Void)) {
    let request = URLRequest(url: URL(string: "https://quipper.github.io/native-technical-exam/playlist.json")!)
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
      guard let data = data else {
        result(.failure(APIError.noData))
        return
      }
      if let error = error {
        result(.failure(error))
        return
      }
      do{
        let lessons = try JSONDecoder().decode([Lesson].self, from: data)
        result(.success(lessons))
      }
      catch{
        result(.failure(error))
      }
    }
    task.resume()
  }
  
}
