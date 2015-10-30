//
//  MemeTableViewCell.swift
//  MemeMe
//
//  Created by Adam Cmiel on 10/30/15.
//  Copyright © 2015 Adam Cmiel. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {
    @IBOutlet weak var memeTextLabel: UILabel!
    @IBOutlet weak var memeImageView: UIImageView!
    var meme: Meme!
}
