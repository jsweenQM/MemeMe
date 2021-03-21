//
//  MemeEditorExtensions.swift
//  MemeMe
//
//  Created by Jon Sweeney on 3/21/21.
//

import UIKit

// MARK: - UI TextField Delegate

extension MemeEditorViewController: UITextFieldDelegate {
    func configureTextField(textField tf: UITextField, text txt: String) {
        tf.text = txt
        tf.delegate = self
        tf.defaultTextAttributes = memeTextAttributes
        tf.textAlignment = .center
    }
}

// MARK: - UI Image Picker Controller Delegate

extension MemeEditorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func getImageFromCameraOrPhoto(source: UIImagePickerController.SourceType) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        pickerController.sourceType = source
        
        present(pickerController, animated: true, completion: nil)
    }
}
