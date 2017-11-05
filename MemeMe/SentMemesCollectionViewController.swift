//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Bruno Barbosa on 29/10/17.
//  Copyright © 2017 Bruno Barbosa. All rights reserved.
//

import UIKit

private let reuseIdentifier = "SentMemesCollectionViewCell"

class SentMemesCollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    var memes: [Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    // MARK: Outlets
    
    @IBOutlet var flowLayout: UICollectionViewFlowLayout!

    // MARK: - Life Cicle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        
        ajdustFlowLayout(viewSize: self.view.bounds.size)
        collectionView?.reloadData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        ajdustFlowLayout(viewSize: size)
    }
    
    // MARK: - UI
    
    private func ajdustFlowLayout(viewSize: CGSize) {
        let space: CGFloat = 2
        let dimension: CGFloat
        
        if viewSize.width >= viewSize.height {
            dimension = (viewSize.width - (7 * space)) / 6.0
            
        } else {
            dimension = (viewSize.width - (4 * space)) / 3.0
        }
        
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: space, bottom: 0, right: space)
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        
        flowLayout.invalidateLayout()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCollectionVIewCellDetail" {
            if let detailViewController = segue.destination as? MemeDetailViewController,
                let cell = sender as? SentMemesCollectionViewCell,
                let indexPath = collectionView?.indexPath(for: cell) {
                detailViewController.meme = memes[indexPath.item];
            }
        }
    }
    
    // MARK: - CollectionView Data

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var numOfRows: Int = 0
        
        if memes.count > 0 {
            numOfRows = memes.count
            collectionView.backgroundView = nil
        } else {
            
            let noDataLabelRect = CGRect(x: 0, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
            let noDataLabel: UILabel = UILabel(frame: noDataLabelRect)
            noDataLabel.text = "No sent memes yet"
            noDataLabel.textColor = UIColor.orange
            noDataLabel.textAlignment = .center
            collectionView.backgroundView = noDataLabel
        }
        
        return numOfRows
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        if let sentMemeCell = cell as? SentMemesCollectionViewCell {
            sentMemeCell.memedImageView.image = memes[indexPath.item].memedImage
        }
    
        return cell
    }
}
