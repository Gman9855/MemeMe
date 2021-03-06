//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Gershy Lev on 4/27/15.
//  Copyright (c) 2015 Gershy Lev. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UICollectionViewController {
    
    var memes: [Meme]!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell: SentMemesCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath) as! SentMemesCollectionViewCell
        cell.imageView.image = memes[indexPath.row].memedImage
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let path = collectionView!.indexPathForCell(sender as! UICollectionViewCell)!
        let memeDetailVC = segue.destinationViewController as! MemeDetailViewController
        memeDetailVC.meme = memes[path.row]
    }


    @IBAction func dismissButtonTapped(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
