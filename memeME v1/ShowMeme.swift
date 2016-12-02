//
//  ShowMeme.swift
//  memeME v1
//
//  Created by Nikhil on 02/12/16.
//  Copyright © 2016 Nikhil. All rights reserved.
//

import Foundation
import UIKit

class ShowMeme : UIViewController {
    @IBOutlet weak var memeDetail: UIImageView!
    var meme : UIImage!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memeDetail.contentMode = .scaleAspectFit
        memeDetail.image = meme
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false        
    }
}
