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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - UI Image Picker Controller Delegate

extension MemeEditorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func getImageFrom(source: UIImagePickerController.SourceType) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        pickerController.sourceType = source
        
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true)
        guard let image = info[.originalImage] as? UIImage else {
            self.showAlert(K.AlertMsg.ImportPhotoErrorTitle, message: K.AlertMsg.ImportPhoroErrorMsg)
            return
        }
        imageIV.image = image
        shareBtn.isEnabled = true
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
