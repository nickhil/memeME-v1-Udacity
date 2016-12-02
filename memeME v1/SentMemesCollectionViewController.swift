//
//  SentMemesCollectionViewController.swift
//  memeME v1
//
//  Created by Nikhil on 02/12/16.
//  Copyright © 2016 Nikhil. All rights reserved.
//

import Foundation
import UIKit

class SentMemesCollectionViewController : UICollectionViewController{
  
    @IBOutlet weak var flowLayout : UICollectionViewFlowLayout!
    //to display the sent memes evenly over the view
    override func viewDidLoad() {
        super.viewDidLoad()
        let space:CGFloat = 3.0
        let width1 = (view.frame.size.width - (5 * space)) / 3.0
        let height1 = (view.frame.size.height - (5 * space)) / 3.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSize(width:width1,height:height1)
    }
  
    //access shared model
    var memes : [MemeObject] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.collectionView?.reloadData()
    }
    
    //return number of cells in the collection view
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
        
    }
    
    //return the cell at the indexPath
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SentMemesCollectionCell", for: indexPath) as! SentMemesCollectionCell
        cell.memeImage?.image = memes[indexPath.row].memedImage
        return cell
        
    }
    
    //convey the task to be performed after the cell is selected
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier:"ShowMeme") as! ShowMeme
        detailController.meme = memes[indexPath.row].memedImage
        self.navigationController!.pushViewController(detailController, animated: true)
        }    
}
