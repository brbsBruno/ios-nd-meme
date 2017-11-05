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
    
    var memes: [Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    @IBOutlet var flowLayout: UICollectionViewFlowLayout!

    // Public methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //generateMemesForTesting()
        ajdustFlowLayout(viewSize: self.view.bounds.size)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView?.reloadData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        ajdustFlowLayout(viewSize: size)
    }
    
    // Private methods
    
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
    
    private func generateMemesForTesting() {
        for _ in 1...20 {
            let size = CGSize(width: 100, height: 100)
            UIGraphicsBeginImageContextWithOptions(size, false, 0)
            UIColor.green.setFill()
            UIRectFill(CGRect(origin: CGPoint.zero, size: size))
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            let meme = Meme(topText: "top", bottomText: "bottom", originalImage: image!, memedImage: image!)
            (UIApplication.shared.delegate as! AppDelegate).memes.append(meme)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        if let sentMemeCell = cell as? SentMemesCollectionViewCell {
            sentMemeCell.memedImageView.image = memes[indexPath.item].memedImage
        }
    
        return cell
    }
}
