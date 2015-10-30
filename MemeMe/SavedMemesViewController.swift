//
//  SavedMemesViewController.swift
//  MemeMe
//
//  Created by Adam Cmiel on 9/7/15.
//  Copyright (c) 2015 Adam Cmiel. All rights reserved.
//
import UIKit

class SavedMemesViewControler: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    var memes: [Meme]?
    @IBOutlet weak var collectionView: UICollectionView!
    
    final func createNewMeme() {
        navigationController?.performSegueWithIdentifier("showNewMemeController", sender: self)
    }
 
    final func saveMeme(meme: Meme) {
        memes?.append(meme)
        reload()
    }
    
    final func reload() {
        collectionView.reloadData()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    // MARK: - UIViewController
    
    final override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "createNewMeme")
        
        // remove shadow on navigation controller navigation item
        navigationController!.view.backgroundColor = UIColor.whiteColor()
        
        if memes == nil {
            memes = []
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reload", name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    final override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMemeDetail" {
            let detailViewController = segue.destinationViewController as! MemeDetailViewController
            detailViewController.meme = memes![0]
        }
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("showMemeDetail", sender: self)
    }
    
    // MARK: - UICollectionViewDataSource
    
    final func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes!.count * 10
    }
    
    final func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        
        let flooredIndex = floor(Double(indexPath.row / 10))
        let meme = memes![Int(flooredIndex)]
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

