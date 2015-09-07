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
        
        navigationItem.title = "New Meme"
        
        [topTextField, bottomTextField].map { $0.delegate = self }
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
        if ((mode == .Camera) && !UIImagePickerController.isSourceTypeAvailable(.Camera)) {
            let alertView = UIAlertView(title: "Error", message: "camera not available", delegate: nil, cancelButtonTitle: "OK")
            alertView.show()
        }
        else {
            let picker = UIImagePickerController()
            picker.sourceType = mode
            picker.delegate = self
            presentViewController(picker, animated: true, completion: nil)
        }
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
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - TextFieldDelegate
    
    final func textFieldShouldReturn(textField: UITextField) -> Bool {
        dispatch_async(dispatch_get_main_queue()) {
            self.keyboardWillDisappear()
        }
        textField.resignFirstResponder()
        return false
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
