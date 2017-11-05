//
//  SentMemesCollectionViewCell.swift
//  MemeMe
//
//  Created by Bruno Barbosa on 29/10/17.
//  Copyright © 2017 Bruno Barbosa. All rights reserved.
//

import UIKit

class SentMemesCollectionViewCell: UICollectionViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var memedImageView: UIImageView!
    
    // MARK: - Life Cicle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        memedImageView.image = nil
    }
}
