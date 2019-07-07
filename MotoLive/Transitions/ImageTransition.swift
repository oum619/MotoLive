//
//  ImageTransition.swift
//  MotoLive
//
//  Created by Motomi Ota on 2019/07/06.
//  Copyright © 2019 Motomi Ota. All rights reserved.
//

import UIKit

protocol ImageTransitionProtocol {
  func tranisitionSetup()
  func tranisitionCleanup()
  func thumbnailInfo() -> (image:UIImage, frame:CGRect)?
}

class ImageTransition: NSObject, UIViewControllerAnimatedTransitioning {
  
  private var fromDelegate: ImageTransitionProtocol?
  
  convenience init(delegate: ImageTransitionProtocol) {
    self.init()
    fromDelegate = delegate
  }
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?)
    -> TimeInterval {
      return 1
  }
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    guard let fromVC = transitionContext.viewController(forKey:.from),
      let toView = transitionContext.view(forKey: .to),
      let imageInfo = fromDelegate?.thumbnailInfo()
      else {
        return
    }
    let containerView = transitionContext.containerView
    // Add a screenshot of the source view without the thumbnail
    fromDelegate?.tranisitionSetup()
    let fromSnapshot = fromVC.view.snapshotView(afterScreenUpdates: true)
    fromSnapshot?.frame = fromVC.view.frame
    if fromSnapshot != nil{
      containerView.addSubview(fromSnapshot!)
    }
    fromDelegate?.tranisitionCleanup()
    
    // add the target view with alpha 0
    toView.alpha = 0
    containerView.addSubview(toView)
    
    // Add the thumbail which will move during transition
    let thumbnail = UIImageView(image: imageInfo.image)
    thumbnail.frame = imageInfo.frame
    thumbnail.contentMode = .scaleAspectFit
    thumbnail.clipsToBounds = true
    containerView.addSubview(thumbnail)
    
    UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.85, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {
      // transition thumbail to center of the target view and fade-in the background of the target view.
      toView.alpha = 1
      thumbnail.center = toView.center
    }, completion:{ (finished) in      
      thumbnail.removeFromSuperview()
      fromSnapshot?.removeFromSuperview()
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    })
  }
}
