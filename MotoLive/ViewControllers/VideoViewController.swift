//
//  VideoViewController.swift
//  MotoLive
//
//  Created by Motomi Ota on 2019/07/05.
//  Copyright © 2019 Motomi Ota. All rights reserved.
//


import AVKit

class VideoViewController: AVPlayerViewController{
  var lesson : Lesson!
  var lessonProgress:LessonProgress!
  
  convenience init(lesson: Lesson, progress:LessonProgress?){
    self.init()
    self.lesson = lesson
    self.lessonProgress = progress ?? LessonProgress(lessonId: lesson.lessonId)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    guard let lesson = lesson, let lessonProgress = lessonProgress else{
      return
    }
    if let videoURL = URL(string:lesson.videoURL){
      player = AVPlayer(url: videoURL)
      let durationInSec = lesson.videoDuration/1000
      let progress = lessonProgress.progress/Float(durationInSec)
      if progress > 0 && progress < 1{
        let timeScale = player!.currentTime().timescale
        player!.seek(to: CMTime(seconds: Double(lessonProgress.progress), preferredTimescale: timeScale))
      }      
    }
    else{
      print("oops this video \(lesson.videoURL) link is broken")
      let alert = UIAlertController(title: "Video Unavailable", message: "This video is unavailable at the moment please try again later.", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
      self.present(alert, animated: true){
        self.dismiss(animated: true, completion: nil)
      }
    }
  }
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    player?.play()
  }
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    if let lessonProgress = lessonProgress, let seconds = player?.currentTime().seconds{
      LessonManager().updateLessonProgress(lessonProgress: lessonProgress, seconds: Float(seconds))
    }
  }
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return .landscape
  }
}
