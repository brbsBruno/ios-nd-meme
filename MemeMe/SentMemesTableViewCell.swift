//
//  SentMemesTableViewCell.swift
//  MemeMe
//
//  Created by Bruno Barbosa on 19/10/17.
//  Copyright © 2017 Bruno Barbosa. All rights reserved.
//

import UIKit

class SentMemesTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var memedImageView: UIImageView!
    @IBOutlet weak var memedLabel: UILabel!

    // MARK: - Life Cicle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        memedImageView.image = nil
        memedLabel.text = ""
    }
}
