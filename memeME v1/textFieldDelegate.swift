//
//  textFieldDelegate.swift
//  memeME v1
//
//  Created by Nikhil on 25/11/16.
//  Copyright © 2016 Nikhil. All rights reserved.
//

import Foundation
import UIKit

class TextFieldDelegate: NSObject,UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.text=="TOP" || textField.text=="BOTTOM"{
            textField.text=""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
