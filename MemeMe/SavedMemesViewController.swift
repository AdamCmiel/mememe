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
        collectionView.reloadData()
    }
    
    // MARK: - UIViewController
    
    final override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "createNewMeme")
        
        if memes == nil {
            memes = []
        }
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
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
        return cell
    }
    
    final func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0;
    }
    
    final func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0;
    }
    
}

