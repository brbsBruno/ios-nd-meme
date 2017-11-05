//
//  SentMemesViewController.swift
//  MemeMe
//
//  Created by Bruno Barbosa on 18/10/17.
//  Copyright © 2017 Bruno Barbosa. All rights reserved.
//

import UIKit

private let reuseIdentifier = "SentMemesTableViewCell"

class SentMemesTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var memes: [Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    // MARK: - Life Cicle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTableViewCellDetail" {
            if let detailViewController = segue.destination as? MemeDetailViewController,
                let cell = sender as? SentMemesTableViewCell,
                let indexPath = tableView.indexPath(for: cell) {
                detailViewController.meme = memes[indexPath.row];
            }
        }
    }
    
    // MARK: - TableView Data
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var numOfRows: Int = 0
        if memes.count > 0 {
            tableView.separatorStyle = .singleLine
            numOfRows = memes.count
            tableView.backgroundView = nil
        } else {
            
            let noDataLabelRect = CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height)
            let noDataLabel: UILabel = UILabel(frame: noDataLabelRect)
            noDataLabel.text = "No sent memes yet"
            noDataLabel.textColor = UIColor.orange
            noDataLabel.textAlignment = .center
            tableView.backgroundView = noDataLabel
            tableView.separatorStyle = .none
        }
        
        return numOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let meme = memes[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SentMemesTableViewCell
        cell.memedImageView.image = meme.memedImage
        cell.memedLabel.text = meme.topText + " " + meme.bottomText
        
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor.orange
        cell.selectedBackgroundView = selectedBackgroundView
        
        return cell
    }
}
