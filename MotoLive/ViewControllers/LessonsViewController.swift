//
//  ViewController.swift
//  MotoLive
//
//  Created by Motomi Ota on 2019/07/03.
//  Copyright © 2019 Motomi Ota. All rights reserved.
//

import UIKit
import AVKit

class LessonsViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  let lessonsManager = LessonViewManager(apiClient: APIClient())
  var lessons:[Lesson] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.delegate = self
    lessonsManager.getLessons(){ (result) in
      switch result {
      case .success(let items):
        DispatchQueue.main.async {
          print("retrived lessons: \(items)")
          self.lessons = items
          self.tableView.reloadData()
        }
      case .failure(let error):
        print("retrive error on get lessons: \(error)")
      }
    }
  }
}

extension LessonsViewController : UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return lessons.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: LessonCell.reuseIdentifier) as! LessonCell
    cell.configure(lesson: lessons[indexPath.row])
    return cell
  }
}

extension LessonsViewController : UITableViewDelegate{
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let lesson = lessons[indexPath.row]
    if let videoURL = URL(string:lesson.videoURL){
      let player = AVPlayer(url: videoURL)
      let playerViewController = VideoViewController()
      playerViewController.player = player
      present(playerViewController, animated: true) {
        player.play()
      }
    }
    else{
      print("oops this video \(lesson.videoURL) link is broken")
      //show an error
    }
  }
}

extension LessonsViewController : UINavigationControllerDelegate{
  func navigationControllerSupportedInterfaceOrientations(_ navigationController: UINavigationController) -> UIInterfaceOrientationMask {
    return .portrait
  }
}

