//
//  ViewController.swift
//  MemeMe
//
//  Created by Gershy Lev on 4/22/15.
//  Copyright (c) 2015 Gershy Lev. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var toolbar: UIToolbar!
    
    @IBOutlet weak var textFieldVerticalPositioningConstraint: NSLayoutConstraint!
    
    var memedImage: UIImage!
    var isTopTextFieldSelected: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topTextField.delegate = self
        bottomTextField.delegate = self
        
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        topTextField.enabled = false
        bottomTextField.enabled = false
        
        applyMemeTextStyleToTextField(topTextField)
        applyMemeTextStyleToTextField(bottomTextField)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        if imageView.image == nil {
            shareButton.enabled = false
        } else {
            shareButton.enabled = true
        }
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }

    @IBAction func cameraButtonTapped(sender: AnyObject) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePickerController, animated: true, completion: nil)
    }

    @IBAction func albumButtonTapped(sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func shareButtonTapped(sender: UIBarButtonItem) {
        memedImage = generateMemedImage()
        var activityVC = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        activityVC.completionWithItemsHandler = { (String, Bool, [AnyObject]!, NSError) -> Void in
            self.save()
            self.toolBarAndNavigationBarHidden(false)
        }
        presentViewController(activityVC, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageView.image = image
            topTextField.enabled = true
            bottomTextField.enabled = true
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if !isTopTextFieldSelected {
            self.view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if !isTopTextFieldSelected {
            self.view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo! [UIKeyboardFrameEndUserInfoKey] as! NSValue //of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == topTextField {
            topTextField.text = ""
            isTopTextFieldSelected = true
        } else {
            bottomTextField.text = ""
            isTopTextFieldSelected = false
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.text == "" {
            if textField == topTextField {
                textField.text = "TOP"
            } else {
                textField.text = "BOTTOM"
            }
        }
        self.view.endEditing(true)
        return true
    }
    
    func toolBarAndNavigationBarHidden(hidden: Bool) {
        toolbar.hidden = hidden
        self.navigationController?.navigationBarHidden = hidden
    }
    
    func applyMemeTextStyleToTextField(textField: UITextField) {
        let memeTextAttributes = [
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSStrokeWidthAttributeName : -2.5,
            NSForegroundColorAttributeName : UIColor.whiteColor(),
        ]
        
        textField.defaultTextAttributes = memeTextAttributes;
        textField.textAlignment = NSTextAlignment.Center
    }
    
    func generateMemedImage() -> UIImage {
        toolBarAndNavigationBarHidden(true)

        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return memedImage
    }
    
    func save() {
        var meme = Meme(topText: topTextField.text, bottomText: bottomTextField.text, image: imageView.image, memedImage: memedImage)
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
}