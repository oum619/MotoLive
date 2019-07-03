//
//  APIClient.swift
//  MotoLive
//
//  Created by Motomi Ota on 2019/07/03.
//  Copyright © 2019 Motomi Ota. All rights reserved.
//

import Foundation

enum Result<T> {
  case success(T)
  case failure(Error)
}

enum APIClientError: Error {
  case noData
}

class APIClient {
  
  func getLessons(result: @escaping ((Result<Data>) -> Void)) {
    let request = URLRequest(url: URL(string: "https://quipper.github.io/native-technical-exam/playlist.json")!)
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
      guard let data = data else {
        result(.failure(APIClientError.noData))
        return
      }
      if let error = error {
        result(.failure(error))
        return
      }
      result(.success(data))
    }
    task.resume()
  }
  
}
