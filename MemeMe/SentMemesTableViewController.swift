//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Gershy Lev on 4/27/15.
//  Copyright (c) 2015 Gershy Lev. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {
    
    var memes: [Meme]! 
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:SentMemesTableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! SentMemesTableViewCell
        let meme = memes[indexPath.row]
        cell.memeTitle.text = meme.topText + " " + meme.bottomText
        cell.memeImageView.image = meme.memedImage
        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let path = tableView.indexPathForSelectedRow()!
        let memeDetailVC = segue.destinationViewController as! MemeDetailViewController
        memeDetailVC.meme = memes[path.row]
    }
    
    @IBAction func dismissButtonTapped(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
