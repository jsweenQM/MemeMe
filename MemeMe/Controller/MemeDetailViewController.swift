//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Jon Sweeney on 3/28/21.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    // MARK: Properties
    
    var detailMeme: Meme!
    
    // MARK: Outlets
    
    @IBOutlet weak var memeImageView: UIImageView!
    
    // MARK: Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        memeImageView.image = detailMeme.imageEdited
        tabBarController?.tabBar.isHidden = true
    }

}
