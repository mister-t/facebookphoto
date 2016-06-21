
//
//  PhotoViewController.swift
//  Facebook
//
//  Created by Tony Yeung on 6/20/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet var parentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var btnActions: UIImageView!
    
    var photoImage: UIImage!
    var originalCenter: CGPoint!
    var originalAlpha:CGFloat = 1
    var fadeMedium:CGFloat = 0.75
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Save the image passed from the feedview
        imageView.image = photoImage
//        imageView.frame.size = photoImage.size
        
        parentView.backgroundColor = UIColor(white: 0, alpha: originalAlpha)
        scrollView.backgroundColor = UIColor(white: 0, alpha: originalAlpha)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onDoneBtnClicked(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    func fadeViews () {
//        scrollView.alpha = 0.95
        parentView.alpha = fadeMedium
    }
    
    func fadeButtons () {
        btnActions.alpha = fadeMedium
        btnDone.alpha = fadeMedium
    }
    
    func showButtons () {
        btnActions.alpha = originalAlpha
        btnDone.alpha = originalAlpha
    }
    
    @IBAction func onPhotoPan(sender: UIPanGestureRecognizer) {
        var point = sender.locationInView(view)
        var velocity = sender.velocityInView(view)
        var translation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            originalCenter = scrollView.center
            print("Gesture began")
        } else if sender.state == UIGestureRecognizerState.Changed {
            print("Gesture is changing")
            
            scrollView.center = CGPoint(x: originalCenter.x, y: originalCenter.y + translation.y)

            fadeViews()
            fadeButtons()
            
            if translation.y > 100 {
                dismissViewControllerAnimated(true, completion: nil)
            }

        } else if sender.state == UIGestureRecognizerState.Ended {

            if translation.y > 50 {
                dismissViewControllerAnimated(true, completion: nil)
            } else {
                scrollView.center = originalCenter
                showButtons()
                
            }
            parentView.alpha = originalAlpha //set parent view to as it's being dragged
            print("Gesture ended")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
