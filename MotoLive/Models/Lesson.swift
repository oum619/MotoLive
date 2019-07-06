//
//  Lesson.swift
//  MotoLive
//
//  Created by Motomi Ota on 2019/07/03.
//  Copyright © 2019 Motomi Ota. All rights reserved.
//

import Foundation
import RealmSwift

class Lesson : Object, Codable {
  @objc dynamic var title: String
  @objc dynamic var presenterName : String
  @objc dynamic var lessonDescription: String
  @objc dynamic var thumbnailURL: String
  @objc dynamic var videoURL: String
  @objc dynamic var videoDuration: Int //video length in miliseconds
  
  enum CodingKeys: String, CodingKey {
    case title
    case presenterName = "presenter_name"
    case lessonDescription = "description"
    case thumbnailURL = "thumbnail_url"
    case videoURL = "video_url"
    case videoDuration = "video_duration"
  }
  override static func primaryKey() -> String? {
    return "videoURL"
  }
}
