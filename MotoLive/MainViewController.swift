//
//  ViewController.swift
//  MotoLive
//
//  Created by Motomi Ota on 2019/07/03.
//  Copyright © 2019 Motomi Ota. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
  
  let lessonsManager = LessonViewManager(apiClient: APIClient())
  var lessons:[Lesson] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    lessonsManager.getLessons(){ (result) in
      switch result {
      case .success(let items):
        self.lessons = items
        print("retrived lessons: \(items)")
      case .failure(let error):
        print("retrive error on get lessons: \(error)")
      }
    }
  }
}


