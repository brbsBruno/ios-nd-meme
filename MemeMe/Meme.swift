//
//  Meme.swift
//  Meme Experiments
//
//  Created by Bruno Barbosa on 23/04/17.
//  Copyright © 2017 Bruno Barbosa. All rights reserved.
//

import UIKit

struct Meme {
    
    var topText: String
    var bottomText: String
    var originalImage: UIImage
    var memedImage: UIImage
    
    init(topText: String, bottomText: String, originalImage: UIImage, memedImage: UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memedImage = memedImage
    }
}
