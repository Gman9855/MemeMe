//
//  Meme.swift
//  MemeMe
//
//  Created by Gershy Lev on 4/25/15.
//  Copyright (c) 2015 Gershy Lev. All rights reserved.
//

import Foundation
import UIKit

class Meme: NSObject {
    var topText: String!
    var bottomText: String!
    var image: UIImage!
    var memedImage: UIImage!
    
    init(topText: String!, bottomText: String!, image: UIImage!, memedImage: UIImage!) {
        self.topText = topText
        self.bottomText = bottomText
        self.image = image
        self.memedImage = memedImage
    }
}



