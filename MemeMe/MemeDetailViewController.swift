//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Bruno Barbosa on 05/11/17.
//  Copyright © 2017 Bruno Barbosa. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var meme: Meme!
    
    // MARK: Outlets
    
    @IBOutlet var imageView: UIImageView!

    // MARK: - Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true

        self.imageView.image = meme.memedImage
    }
}
