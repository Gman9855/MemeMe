//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Gershy Lev on 4/29/15.
//  Copyright (c) 2015 Gershy Lev. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    weak var imageView: UIImageView!
    @IBOutlet weak var gestureRecognizer: UITapGestureRecognizer!

    var meme : Meme?
    var showing : Bool?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        imageView.image = meme?.memedImage
    }
        
    override func loadView() {
        var imageView:UIImageView = UIImageView(frame: CGRectZero)
        imageView.contentMode = .ScaleAspectFit
        imageView.backgroundColor = UIColor.whiteColor()
        self.imageView = imageView
        self.view = imageView
    }
}
