//
//  Meme.swift
//  MemeMe
//
//  Created by Adam Cmiel on 9/7/15.
//  Copyright (c) 2015 Adam Cmiel. All rights reserved.
//
import UIKit

/// Generate a memed image from an image and two strings of text
/// borrow the view hierarchy of the generating view controller
struct Meme {
    var image: UIImage
    var topText: String
    var bottomText: String
    var memedImage: UIImage
    
    init(topText top: String, bottomText bottom: String, image _image: UIImage, view: UIView) {
        topText = top
        bottomText = bottom
        image = _image
        
        // remove the toolbar from the memed image
        let bounds = CGRect(origin: view.bounds.origin, size: CGSize(width: view.bounds.width, height: view.bounds.height - 44.0))
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, 0)
        view.drawViewHierarchyInRect(bounds, afterScreenUpdates: true)
        memedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
}
