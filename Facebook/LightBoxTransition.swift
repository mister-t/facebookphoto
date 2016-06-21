//
//  LightBoxTransition.swift
//  Facebook
//
//  Created by Sumit Kohli on 6/17/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class LightBoxTransition: BaseTransition {
    var blackView = UIView()
    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        let tabViewController = fromViewController as! UITabBarController
        let navigationController = tabViewController.selectedViewController as! UINavigationController
        let newsFeedController = navigationController.topViewController as! NewsFeedViewController
        let photoViewController = toViewController as! PhotoViewController
        
        //let newsFeedController = fromViewController as! NewsFeedViewController
        //let photoViewController = toViewController as! PhotoViewController
        
        //Added fake ImageView to simulate the NewsFeedViewController while the image is being dragged down
        let movingImageView = UIImageView()
        movingImageView.image = newsFeedController.selectedImageView.image
        movingImageView.frame = newsFeedController.selectedImageView.frame
        movingImageView.contentMode = newsFeedController.selectedImageView.contentMode
        containerView.addSubview(movingImageView)
        
        newsFeedController.selectedImageView.alpha = 0
        photoViewController.imageView.alpha = 0

        
//        blackView.backgroundColor = UIColor(white: 0, alpha: 0.9)
//        blackView.frame.size = containerView.frame.size
//        blackView.alpha = 0
//        containerView.insertSubview(blackView, belowSubview: toViewController.view)
        
        
        toViewController.view.alpha = 0
        toViewController.view.transform = CGAffineTransformMakeScale(0, 0)
        UIView.animateWithDuration(duration, animations: {
            movingImageView.frame = photoViewController.imageView.frame
            toViewController.view.alpha = 1
            toViewController.view.transform = CGAffineTransformMakeScale(1, 0.9)
//            self.blackView.alpha = 1
        }) { (finished: Bool) -> Void in
            photoViewController.imageView.alpha = 1
            newsFeedController.selectedImageView.alpha = 1
            movingImageView.alpha = 0
            self.finish()
        }
    }
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        fromViewController.view.alpha = 1
        fromViewController.view.transform = CGAffineTransformMakeScale(1, 0.9)
        UIView.animateWithDuration(duration, animations: {
            self.blackView.alpha = 0
            fromViewController.view.alpha = 0
        fromViewController.view.transform = CGAffineTransformMakeScale(0.001, 0.001)
        }) { (finished: Bool) -> Void in
            self.finish()
        }
    }

}
