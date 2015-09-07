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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let backButton = UIBarButtonItem()
        backButton.title = "Save"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        navigationItem.title = "New Meme"
    }
    
    final func selectPicture(mode: UIImagePickerControllerSourceType) {
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

    // MARK: - ImagePickerDelegate
    
    final func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        imageView.image = image
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - TextFieldDelegate
    
    final func textFieldShouldReturn(textField: UITextField) -> Bool {
        return true
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
