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
  @IBOutlet weak var progressBar: UIProgressView!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    duration.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    duration.layer.cornerRadius = 5
  }
  
  func configure(lesson:Lesson, lessonProgress:LessonProgress?){
    thumbnail.sd_setImage(with: URL(string: lesson.thumbnailURL), placeholderImage: nil, options: [], context: nil, progress: nil, completed: nil)
    let durationInSec = lesson.videoDuration/1000
    duration.text = parseDuration(duration:durationInSec)
    byline.text = "\(lesson.title) / \(lesson.presenterName)"
    lessonDescription.text = lesson.lessonDescription
    if let lessonProgress = lessonProgress{
      progressBar.progress = lessonProgress.progress/Float(durationInSec)
      progressBar.isHidden = false
      setCompleted(completed: lessonProgress.completed)
    }
    else{
      progressBar.isHidden = true
      setCompleted(completed: false)      
    }
  }
  
  func setCompleted(completed:Bool){
    let alpha:CGFloat = completed ? 0.7 : 1
    byline.textColor = UIColor(rgb:0x2a439a).withAlphaComponent(alpha)
    thumbnail.alpha = alpha
    duration.alpha = alpha
  }
  func parseDuration(duration : Int) -> String{
    var durationStr = ""
    let seconds = duration % 60
    let minutes = (duration / 60) % 60
    let hours = (duration / (60*60)) % 60
    if hours > 0{
      durationStr+="\(hours):"
    }
    durationStr+="\(minutes):\(seconds)"
    return durationStr
  }
}
