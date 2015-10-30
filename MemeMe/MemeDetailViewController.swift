//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Adam Cmiel on 10/24/15.
//  Copyright © 2015 Adam Cmiel. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    @IBOutlet weak var memeImage: UIImageView!
    var meme: Meme!
    
    override func viewWillAppear(animated: Bool) {
        memeImage.image = meme.memedImage
        
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        
        navigationController!.navigationBar.topItem!.backBarButtonItem = backButton
    }
    
}
