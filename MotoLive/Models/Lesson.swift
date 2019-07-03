//
//  Lesson.swift
//  MotoLive
//
//  Created by Motomi Ota on 2019/07/03.
//  Copyright © 2019 Motomi Ota. All rights reserved.
//

import Foundation

struct Lesson: Codable {
  let title, presenterName, lessonDescription: String
  let thumbnailURL: String
  let videoURL: String
  let videoDuration: Int
  
  enum CodingKeys: String, CodingKey {
    case title
    case presenterName = "presenter_name"
    case lessonDescription = "description"
    case thumbnailURL = "thumbnail_url"
    case videoURL = "video_url"
    case videoDuration = "video_duration"
  }
}
