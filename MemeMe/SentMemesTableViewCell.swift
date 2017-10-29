//
//  SentMemesTableViewCell.swift
//  MemeMe
//
//  Created by Bruno Barbosa on 19/10/17.
//  Copyright © 2017 Bruno Barbosa. All rights reserved.
//

import UIKit

class SentMemesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var memedImageView: UIImageView!
    @IBOutlet weak var memedLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        memedImageView.image = nil
        memedLabel.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
