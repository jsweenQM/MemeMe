//
//  Constants.swift
//  MemeMe
//
//  Created by Jon Sweeney on 3/21/21.
//

import Foundation

struct K {
    static let appTitle = "MemeMe"
    
    struct MemeImage {
        static let textTopDefault = "TOP"
        static let textBottomDefault = "BOTTOM"
    }
    
    struct AlertMsg {
        static let DismissAlert = "Dismiss"
        static let SharingMemeErrorTitle = "Sharing Failed"
        static let SharingMemeErrorMsg = "Erorr Sharing the Creted Meme."
        static let ImportPhotoErrorTitle = "Using a Photo Failed"
        static let ImportPhoroErrorMsg = "Error Importing the Photo from Your Album. Please Check the Photo's Format Type."
    }
    
    struct Cell {
        static let collectionViewReuseId = "MemeCollectionViewCell"
        static let tableViewReuseId = "MemeTableViewCell"
    }
    
    struct VC {
        static let detailMemeId = "MemeDetailViewController"
        static let editMemeId = "MemeEditorViewController"
    }
}
