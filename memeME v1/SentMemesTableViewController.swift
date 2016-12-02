//
//  SentMemesTableViewController.swift
//  memeME v1
//
//  Created by Nikhil on 02/12/16.
//  Copyright © 2016 Nikhil. All rights reserved.
//

import Foundation
import UIKit

class SentMemesTableViewController : UITableViewController{

    var memes : [MemeObject] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    } //access shared model "memes"
    
    //give the count of the total rows in table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    //reload the table view
    override func viewDidAppear(_ animated: Bool) {
       super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
    //return cell at the specified index path
    //dequeue and reuse the cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SentMemesTableRow")!
        cell.imageView?.image = memes[indexPath.row].memedImage
        cell.textLabel?.text = memes[indexPath.row].topText + "..." + memes[indexPath.row].bottomText
        return cell
    }
   
    //task to be performed when the row gets selected
 override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 let detailController = self.storyboard?.instantiateViewController(withIdentifier: "ShowMeme") as! ShowMeme
    detailController.meme = memes[indexPath.row].memedImage
    //push view Controller with the enlarged meme, over the navigation stack
    self.navigationController!.pushViewController(detailController, animated: true)
 
 }

 
}
