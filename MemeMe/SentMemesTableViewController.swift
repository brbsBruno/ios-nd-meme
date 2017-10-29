//
//  SentMemesViewController.swift
//  MemeMe
//
//  Created by Bruno Barbosa on 18/10/17.
//  Copyright © 2017 Bruno Barbosa. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {
    
    var memes: [Meme]!
    let cellIdentifier = "SentMemesTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let meme = memes[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SentMemesTableViewCell
        cell.memedImageView.image = meme.memedImage
        cell.memedLabel.text = meme.topText + " " + meme.bottomText
        
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor.orange
        cell.selectedBackgroundView = selectedBackgroundView
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
}
