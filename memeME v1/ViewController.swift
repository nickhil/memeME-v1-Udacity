//
//  ViewController.swift
//  memeME v1
//
//  Created by Nikhil on 24/11/16.
//  Copyright © 2016 Nikhil. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBOutlet weak var ImagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    let textFieldDelegate = TextFieldDelegate()
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
 
    @IBOutlet weak var shareButton: UIBarButtonItem!
 
    //dictionary for font attributes
    let memeTextAttributes = [NSStrokeColorAttributeName:UIColor.black, NSForegroundColorAttributeName:UIColor.white, NSFontAttributeName:UIFont(name: "HelveticaNeue-CondensedBlack",size:40)!, NSStrokeWidthAttributeName: -4.0] as [String : Any]
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ImagePickerView.contentMode = UIViewContentMode.scaleAspectFit
        
        setTextField(topTextField,text: "TOP")
        setTextField(bottomTextField, text: "BOTTOM")
    }
    
    //selecting image from Album
    @IBAction func selectFromAlbum(_ sender: AnyObject) {
        selectImage(source: "album")
 }
    
    //taking image from camera
    @IBAction func selectFromCamera(_ sender: AnyObject) {
        selectImage(source: "camera")
    }
    
   //setting the source of the image
    func selectImage(source: String){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        switch source{
        case "album":
        imagePickerController.sourceType = .photoLibrary
        case "camera":
        imagePickerController.sourceType = .camera
        default : break
        
        }
        
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
     //seting image to UIImageView
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            ImagePickerView.image = image
            self.dismiss(animated: true, completion: nil)        }
        cancelButton.isEnabled=true
        shareButton.isEnabled=true
        
    }
    
    //setting properties for textfields
    func setTextField(_ textField: UITextField, text: String){
        textField.text=text
        textField.defaultTextAttributes=memeTextAttributes
        textField.textAlignment=NSTextAlignment.center
        textField.delegate=textFieldDelegate
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera) //enable/disable camera button on camera availability
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unsubscribeFromKeyboardNotifications()
    }
    
    //move up the frame inorder of keyboard to display
    func keyboardWillShow(_ notification:Notification) {
        if bottomTextField.isFirstResponder{
        view.frame.origin.y = -getKeyboardHeight(notification)
      }
    }
    
    //hide the keyboard and re-position the frame
    func keyboardWillHide(_ notification:Notification){
        if bottomTextField.isFirstResponder{
        view.frame.origin.y = 0
      }
    }

    //calculate the keyboard height
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }

    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide(_ :)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
    }

    //generating the meme
    func generateMemedImage() -> UIImage {
        
        bottomToolbar.isHidden=true
        topToolbar.isHidden=true
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        bottomToolbar.isHidden=false
        topToolbar.isHidden=false
        return memedImage
    }
    
    //saving the meme in the struct form
    func save()->MemeObject {
        let meme = MemeObject(topText: topTextField.text!, bottomText: bottomTextField.text!, image: ImagePickerView.image!, memedImage: generateMemedImage())
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
        return meme
    }
    
    
 //to share the meme
    @IBAction func shareMeme(_ sender: AnyObject) {
            let activityController = UIActivityViewController(activityItems: [generateMemedImage()], applicationActivities: nil)
            activityController.completionWithItemsHandler = {
                activity,completed,item,error in if completed {
                    let _ = self.save()
                }
                self.dismiss(animated: true, completion: nil)
            }
            
            present(activityController, animated: true, completion: nil)
    }
        
   
    @IBAction func cancel(_ sender: AnyObject) {
        ImagePickerView.image = nil
        shareButton.isEnabled = false
        cancelButton.isEnabled = false
        viewDidLoad()

       }
    }
