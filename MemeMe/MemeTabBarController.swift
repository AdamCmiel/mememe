//
//  MemeTabBarController.swift
//  MemeMe
//
//  Created by Adam Cmiel on 10/31/15.
//  Copyright © 2015 Adam Cmiel. All rights reserved.
//

import UIKit

class MemeTabBarController: UITabBarController {
    internal var memes: [Meme]!
    
    final override func awakeFromNib() {
        super.awakeFromNib()
        
        if memes == nil {
            memes = []
        }
    }
    
    final func saveMeme(meme: Meme) {
        memes.append(meme)
    }
    
    // MARK: - UIViewController
    
    final override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "createNewMeme")
        // remove shadow on navigation controller navigation item
        navigationController!.view.backgroundColor = UIColor.whiteColor()
    }
    
    final func createNewMeme() {
        navigationController?.performSegueWithIdentifier("showNewMemeController", sender: self)
    }
}
