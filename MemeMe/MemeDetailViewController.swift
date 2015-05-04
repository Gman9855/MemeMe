//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Gershy Lev on 4/29/15.
//  Copyright (c) 2015 Gershy Lev. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!

    var meme : Meme?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        imageView.image = meme?.memedImage
    }
}
