//
//  LessonCell.swift
//  MotoLive
//
//  Created by Motomi Ota on 2019/07/03.
//  Copyright © 2019 Motomi Ota. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class LessonCell : UITableViewCell{
  
  static let reuseIdentifier = "LessonCell"
  
  @IBOutlet weak var duration: UITextView!
  @IBOutlet weak var thumbnail: UIImageView!
  @IBOutlet weak var byline: UILabel!
  @IBOutlet weak var lessonDescription: UILabel!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    duration.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    duration.layer.cornerRadius = 5    
    
    
  }
  func configure(lesson:Lesson){
    thumbnail.sd_setImage(with: URL(string: lesson.thumbnailURL), placeholderImage: nil, options: [], context: nil, progress: nil, completed: nil)
    duration.text = parseDuration(duration: lesson.videoDuration)
    byline.text = "\(lesson.title) / \(lesson.presenterName)"
    lessonDescription.text = lesson.lessonDescription
  }
  
  func parseDuration(duration : Int) -> String{
    var durationStr = ""
    let milliseconds = duration/1000
    let seconds = milliseconds % 60
    let minutes = (milliseconds / 60) % 60
    let hours = (milliseconds / (60*60)) % 60
    if hours > 0{
      durationStr+="\(hours):"
    }
    durationStr+="\(minutes):\(seconds)"
    return durationStr
  }
}
