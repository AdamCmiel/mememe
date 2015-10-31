//
//  SavedMemesViewController.swift
//  MemeMe
//
//  Created by Adam Cmiel on 9/7/15.
//  Copyright (c) 2015 Adam Cmiel. All rights reserved.
//
import UIKit

class SavedMemesViewControler: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var memes: [Meme] {
        get { return self.root.memes }
    }
    var root: MemeTabBarController {
        get { return self.navigationController!.viewControllers.first as! MemeTabBarController }
        
    }
    @IBOutlet weak var collectionView: UICollectionView!
    
    final func reload() {
        collectionView.reloadData()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    // MARK: - UIViewController
    
    final override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reload", name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    final override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        reload()
    }
    
    final override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let detailViewController = segue.destinationViewController as! MemeDetailViewController
        let path = collectionView.indexPathsForSelectedItems()![0].row
        detailViewController.meme = memes[path]
    }
    
    // MARK: - UICollectionViewDataSource
    
    final func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    final func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        
        let meme = memes[indexPath.row]
        cell.imageView.image = meme.memedImage
        cell.meme = meme
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let width = view.bounds.width
        var boxWidth: CGFloat
        
        switch UIApplication.sharedApplication().statusBarOrientation {
        case .Portrait:
            fallthrough
        case .PortraitUpsideDown:
            boxWidth = floor(width / 3)
        default:
            boxWidth = floor(width / 5) - 1.0
        }
        
        return CGSize(width: boxWidth, height: boxWidth)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }
    
    final func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
    
    final func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
    
    final func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSizeZero
    }
    
    final func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeZero
    }

}

