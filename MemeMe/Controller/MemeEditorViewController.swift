//
//  ViewController.swift
//  MemeMe
//
//  Created by Jon Sweeney on 3/21/21.
//

import UIKit

class MemeEditorViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var shareBtn: UIBarButtonItem!
    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    @IBOutlet weak var cameraBtn: UIBarButtonItem!
    @IBOutlet weak var albumBtn: UIBarButtonItem!
    @IBOutlet weak var topTF: UITextField!
    @IBOutlet weak var bottomTF: UITextField!
    @IBOutlet weak var imageIV: UIImageView!
    
    // MARK: Variables
    
    let topText = K.textTopDefault
    let bottomText = K.textBottomDefault
    
    var memeImage: UIImage! = nil
    var meme: Meme? = nil
    
    // MARK: - Meme's Text Attributes
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 44)!,
        NSAttributedString.Key.strokeWidth: -4.5
    ]
    
    // MARK: Methods
    
    // MARK: - Override methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        subscribeToKeyboardNotifications()
        cameraBtn.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        configureTextField(textField: topTF, text: K.textTopDefault)
        configureTextField(textField: bottomTF, text: K.textBottomDefault)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unsubscribeFromKeyboardNotifications()
    }
    
    // MARK: - Actions
    
    // Get the image from either photo or album
    @IBAction func getImage(_ sender: UIBarItem) {
        // 0 - camera  1 - album
        if sender.tag == 0 {
            // Take photo
            print("Taking photo...")
        } else {
            // Get Album Photo
            print("Picking photo from album...")
        }
    }
    
    // Share the meme
    @IBAction func shareMeme(_ sender: Any) {
        // share meme
        print("Sharing meme...")
    }
    
    
    // Reset the meme
    @IBAction func resetMeme(_ sender: Any) {
        // reset meme
        print("Reseting meme...")
    }
    
    // MARK: - Functionality
    
    func saveMeme() -> Meme? {
        let meme = Meme(textTop: "", textBottom: "", imageOriginal: UIImage(), imageEdited: UIImage())
        // Do stuff
        
        return meme
    }
    
    func generateMemedImage() -> UIImage {

        // TODO: Hide toolbar and navbar

        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        // TODO: Show toolbar and navbar

        return memedImage
    }
    
    // MARK: - Helpers
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        
        return keyboardSize.cgRectValue.height
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if bottomTF.isEditing {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        if bottomTF.isEditing {
            view.frame.origin.y = 0
        }
    }

    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    private func resetUI() {
        configureTextField(textField: topTF, text: K.textTopDefault)
        configureTextField(textField: bottomTF, text: K.textBottomDefault)
        imageIV.image = nil
        shareBtn.isEnabled = false
    }
}

