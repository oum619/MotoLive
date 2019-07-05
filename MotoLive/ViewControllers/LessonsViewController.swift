//
//  ViewController.swift
//  MotoLive
//
//  Created by Motomi Ota on 2019/07/03.
//  Copyright © 2019 Motomi Ota. All rights reserved.
//

import UIKit

class LessonsViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  let refreshControl = UIRefreshControl()
  var lessons = LessonManager.shared.getLessons()
  var lessonProgress = LessonManager.shared.getLessonsProgress()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.tableFooterView = UIView()
    tableView.refreshControl = refreshControl
    refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
    pullToRefresh()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
    return .portrait
  }
  
  @objc func pullToRefresh(){
    LessonManager.shared.downloadLessons{ (result) in
      self.refreshControl.endRefreshing()
      switch result {
      case .success(let items):
        DispatchQueue.main.async {
          print("retrived lessons: \(items)")
          self.lessons = items
          self.tableView.reloadData()
        }
      case .failure(let error):
        print("retrive error on get lessons: \(error)")
        //show error
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
    let lesson = lessons[indexPath.row]
    let progress = lessonProgress.filter{$0.lessonId == lesson.lessonId}.first
    cell.configure(lesson: lesson ,progress: progress)
    return cell
  }
}

extension LessonsViewController : UITableViewDelegate{
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let lesson = lessons[indexPath.row]
    let progress = lessonProgress.filter{$0.lessonId == lesson.lessonId}.first
    let videoVC = VideoViewController(lesson: lesson, progress: progress)
    present(videoVC, animated: true, completion: nil)
  }
}


