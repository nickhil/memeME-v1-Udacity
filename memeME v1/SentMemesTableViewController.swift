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

   
    var memes : [MemeObject]!
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    override func viewDidAppear(_ animated: Bool) {
         self.tableView.reloadData()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SentMemesTableRow")!
        cell.imageView?.image = memes[indexPath.row].memedImage
        cell.textLabel?.text = memes[indexPath.row].topText + "..." + memes[indexPath.row].bottomText
        return cell
    }
   
    
 override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 let detailController = self.storyboard?.instantiateViewController(withIdentifier: "ShowMeme") as! ShowMeme
   //Load ImageView with Meme later
 
 self.navigationController!.pushViewController(detailController, animated: true)
 
 }

 
}
