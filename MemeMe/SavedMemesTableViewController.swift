//
//  SavedMemesTableViewController.swift
//  MemeMe
//
//  Created by Adam Cmiel on 10/31/15.
//  Copyright © 2015 Adam Cmiel. All rights reserved.
//

import UIKit

class SavedMemesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var memes: [Meme] {
        get { return root.memes }
    }
    var root: MemeTabBarController {
        get { return navigationController!.viewControllers.first as! MemeTabBarController }
        
    }
    @IBOutlet weak var tableView: UITableView!
    
    final func reload() {
        tableView.reloadData()
    }
   
    // MARK: - UIViewController
    
    final override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reload", name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    final override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        reload()
    }
    
    final override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let detailViewController = segue.destinationViewController as! MemeDetailViewController
        let path = tableView.indexPathForSelectedRow!.row
        detailViewController.meme = memes[path]
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tableCell", forIndexPath: indexPath)
        
        let meme = memes[indexPath.row]
        cell.imageView!.image = meme.memedImage
        cell.textLabel!.text = meme.topText + " " + meme.bottomText
        return cell
    }
}
