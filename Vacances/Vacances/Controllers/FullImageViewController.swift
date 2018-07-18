//
//  FullImageViewController.swift
//  Vacances
//
//  Created by JL on 6/29/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit


class FullImageViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var fullImageView: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var fullImage = UIImage(named: "16")


    override func viewDidLoad() {
        super.viewDidLoad()

        fullImageView.image = fullImage
        
        //Madatory delegate chaining
        scrollView.delegate = self
        
        //For our scrollview zoomScale
        
        //minimum 1 , actual size of image
        scrollView.minimumZoomScale = 1
        
        //Maximum 4 times the sizee of the image
        scrollView.maximumZoomScale = 4
        //Required
        scrollView.contentSize = fullImageView.frame.size
        
        
    }
    
    
    
    
    //For zooming on the pictures
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        
        return fullImageView
    }
    
}


