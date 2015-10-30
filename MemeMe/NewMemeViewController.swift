//
//  NewMemeViewController.swift
//  MemeMe
//
//  Created by Adam Cmiel on 9/7/15.
//  Copyright (c) 2015 Adam Cmiel. All rights reserved.
//

import UIKit

class NewMemeViewController: UIViewController, UIImagePickerControllerDelegate, UITextFieldDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBAction func cameraButtonPressed(sender: AnyObject) {
        selectPicture(.Camera)
    }
    
    @IBAction func galleryButtonPressed(sender: AnyObject) {
        selectPicture(.PhotoLibrary)
    }
    
    final override func viewDidLoad() {
        super.viewDidLoad()

        let backButton = UIBarButtonItem()
        backButton.title = "Save"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController?.delegate = self
        
        navigationItem.title = "New Meme"
        
        [topTextField, bottomTextField].forEach {
            $0.delegate = self
            
            // credit: http://stackoverflow.com/a/30052126
            $0.defaultTextAttributes = [
                NSStrokeColorAttributeName: UIColor.blackColor(),
                NSForegroundColorAttributeName: UIColor.whiteColor(),
                NSStrokeWidthAttributeName: -2.5,
                NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 50.0)!
            ]
            
            $0.textAlignment = .Center
        }
        
        if !UIImagePickerController.isSourceTypeAvailable(.Camera) {
            cameraButton.enabled = false
        }
    }
    
    final override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    final override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    final private func selectPicture(mode: UIImagePickerControllerSourceType) {
        let picker = UIImagePickerController()
        picker.sourceType = mode
        picker.delegate = self
        presentViewController(picker, animated: true, completion: nil)
    }
    
    // MARK: - move keyboard
    
    // Credit: Udacity course notes
    final private func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
    }
    
    final private func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    }
    
    final func keyboardWillShow(notification: NSNotification) {
        // only shift up the view if the bottom text view is editing
        if bottomTextField.editing {
            let userInfo = notification.userInfo
            let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
            let height = keyboardSize.CGRectValue().height
            self.view.frame.origin.y -= height
        }
    }
    
    final private func keyboardWillDisappear() {
        UIView.animateWithDuration(0.3, animations: {
            self.view.frame.origin.y = 0
        }, completion: { flag in
            self.view.frame.origin.y = 0
        })
    }

    // MARK: - ImagePickerDelegate
    
    final func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        imageView.image = image
        imageView.contentMode = .ScaleAspectFill
        picker.dismissViewControllerAnimated(true, completion: nil)
        
        view.bringSubviewToFront(topTextField)
        view.bringSubviewToFront(bottomTextField)
    }
    
    // MARK: - TextFieldDelegate
    
    final func textFieldShouldReturn(textField: UITextField) -> Bool {
        dispatch_async(dispatch_get_main_queue()) {
            self.keyboardWillDisappear()
        }
        textField.resignFirstResponder()
        return false
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//        
//        let receiver = segue.destinationViewController as! SavedMemesViewControler
//        
//        let meme = Meme(topText: topTextField.text, bottomText: bottomTextField.text, image: imageView.image!, view: view)
//        receiver.saveMeme(meme)
//        
//    }
    
    final func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        
        if let vc = viewController as? SavedMemesViewControler {
            if let img = imageView.image {
                let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, image: img, view: view)
                vc.saveMeme(meme)
            }
        }
    }

}

