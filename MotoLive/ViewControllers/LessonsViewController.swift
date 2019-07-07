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
  var hideSelectedCell: Int?
  var contectOffset:CGPoint = .zero
  
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
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    tableView.setContentOffset(contectOffset, animated: true)
  }
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    contectOffset = tableView.contentOffset
  }
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
    return .portrait
  }
  
  @objc func pullToRefresh(){
    LessonManager.shared.downloadLessons{ (result) in
      self.refreshControl.endRefreshing()
      switch result {
      case .success(let items):
        print("retrived lessons: \(items)")
        self.lessons = items
        self.tableView.reloadData()
      case .failure(let error):
        print("retrive error on get lessons: \(error)")
        let alert = UIAlertController(title: "Network Error", message: "Please check your Internet connection and pull to refresh to try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
        self.present(alert, animated: true){
          self.tableView.setContentOffset(.zero, animated: true)
        }
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
    let progress = lessonProgress.filter{$0.videoURL == lesson.videoURL}.first
    cell.configure(lesson: lesson ,lessonProgress: progress)
    cell.thumbnail.isHidden = hideSelectedCell == indexPath.row
    return cell
  }
}

extension LessonsViewController : UITableViewDelegate{
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let lesson = lessons[indexPath.row]
    hideSelectedCell = indexPath.row
    let progress = lessonProgress.filter{$0.videoURL == lesson.videoURL}.first
    let videoVC = VideoViewController(lesson: lesson, progress: progress)
    videoVC.transitioningDelegate = self
    present(videoVC, animated: true, completion: nil)
  }
}


extension LessonsViewController : ImageTransitionProtocol{
  
  // hide selected thumbnail for tranisition snapshot
  func tranisitionSetup(){
    tableView.reloadData()
  }
  
  // unhide selected after tranisition snapshot is taken
  func tranisitionCleanup(){
    hideSelectedCell = nil
    tableView.reloadData()
  }
  
  // Return selected cell thumbnail image
  func thumbnailInfo() -> (image: UIImage, frame: CGRect)? {    
    if let indexPath = tableView.indexPathForSelectedRow{
      if let selectCell = tableView.cellForRow(at: indexPath) as? LessonCell{
        var cellRect = tableView.convert(selectCell.frame, to: nil)
        cellRect.size.height = selectCell.thumbnail.frame.height
        if let thumbnail = selectCell.thumbnail?.image{
          return (image:thumbnail, frame:cellRect)
        }
      }
    }
    return nil
  }
}

extension LessonsViewController : UIViewControllerTransitioningDelegate{
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController)
    -> UIViewControllerAnimatedTransitioning? {
      return ImageTransition(delegate: self)
  }
  func animationController(forDismissed dismissed: UIViewController)
    -> UIViewControllerAnimatedTransitioning? {
      return nil
  }
}
