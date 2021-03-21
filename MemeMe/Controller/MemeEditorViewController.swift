//
//  ViewController.swift
//  MemeMe
//
//  Created by Jon Sweeney on 3/21/21.
//

import UIKit

class MemeEditorViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var shareBtn: UIBarButtonItem!
    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    @IBOutlet weak var cameraBtn: UIBarButtonItem!
    @IBOutlet weak var albumBtn: UIBarButtonItem!
    @IBOutlet weak var topTF: UITextField!
    @IBOutlet weak var bottomTF: UITextField!
    @IBOutlet weak var imageIV: UIImageView!
    @IBOutlet weak var toolbar: UIToolbar!
    
    // MARK: Variables
    
    let topText = K.textTopDefault
    let bottomText = K.textBottomDefault
    
    var memedImage: UIImage! = nil
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
            getImageFrom(source: .camera)
        } else {
            // Get Photo Library
            getImageFrom(source: .photoLibrary)
        }
    }
    
    // Share the meme
    @IBAction func shareMeme(_ sender: Any) {
        memedImage = generateMemedImage()
        let aVC = UIActivityViewController(activityItems: [memedImage!], applicationActivities: nil)
        aVC.popoverPresentationController?.sourceView = self.view
        self.present(aVC, animated: true, completion: nil)
        aVC.completionWithItemsHandler = {(activity, success, items, error) in
            if success {
                self.meme = self.saveMeme()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    // Reset the meme
    @IBAction func resetMeme(_ sender: Any) {
        memedImage = nil
        resetUI()
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Functionality
    
    func saveMeme() -> Meme? {
        let image = imageIV.image ?? UIImage(named: "default")
        let meme = Meme(textTop: topTF.text!, textBottom: bottomTF.text!, imageOriginal: image!, imageEdited: memedImage)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.self.reloadInputViews()
        
        return meme
    }
    
    func generateMemedImage() -> UIImage {
        // Hide Nav and Toolbar
        hideBars(true)
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Show Nav and Toolbar
        hideBars(false)
        
        return memedImage
    }
    
    // MARK: - Helpers
    
    func hideBars(_ hide: Bool) {
        navBar.isHidden = hide
        toolbar.isHidden = hide
    }
    
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
    
    // Show alert to user
    func showAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: K.AlertMsg.DismissAlert, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

