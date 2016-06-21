//
//  NewsFeedViewController.swift
//  Facebook
//
//  Created by Timothy Lee on 8/3/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var homeFeedImage: UIImageView!
    
    //Place holders
    var selectedImageView: UIImageView!
    var lightBoxTransition: LightBoxTransition!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure the content size of the scroll view
        scrollView.contentSize = CGSizeMake(320, homeFeedImage.image!.size.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        scrollView.contentInset.top = 0
        scrollView.contentInset.bottom = 50
        scrollView.scrollIndicatorInsets.top = 0
        scrollView.scrollIndicatorInsets.bottom = 50
    }
    
    @IBAction func onPhotoTapped(sender: UITapGestureRecognizer) {
        selectedImageView = sender.view as! UIImageView
        
        performSegueWithIdentifier("PhotoViewSegue", sender: selectedImageView)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {

        let destinationViewController = segue.destinationViewController as! PhotoViewController
        
        destinationViewController.photoImage = self.selectedImageView.image
        
        // Set the modal presentation style of your destinationViewController to be custom.
        destinationViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        
        lightBoxTransition = LightBoxTransition()
        
        destinationViewController.transitioningDelegate = lightBoxTransition
        
        lightBoxTransition.duration = 0.4
        
        
    }
}
