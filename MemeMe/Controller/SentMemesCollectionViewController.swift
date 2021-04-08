//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Jon Sweeney on 3/28/21.
//

import UIKit

//private let reuseIdentifier = "Cell"

class SentMemesCollectionViewController: UICollectionViewController {

    // MARK: Properties
    
    var memes: [Meme]! {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.memes
    }
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let rtBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(navigateToMemeEditor))
        navigationItem.setRightBarButton(rtBarButtonItem, animated: animated)
        collectionView.reloadData()
        tabBarController?.tabBar.isHidden = false
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.Cell.collectionViewReuseId, for: indexPath) as! MemeCollectionViewCell
    
        // Configure the cell
        if let image = cell.imageView {
            image.image = memes[indexPath.row].imageEdited
        }
        let imageView: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 128, height: 256))
        let image: UIImage = memes[indexPath.row].imageEdited
        imageView.image = image
        cell.contentView.addSubview(imageView)
        
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let memeDetailVC = storyboard!.instantiateViewController(identifier: K.VC.detailMemeId) as! MemeDetailViewController
        memeDetailVC.detailMeme = memes[indexPath.row]
        navigationController!.pushViewController(memeDetailVC, animated: true)
    }

    // MARK: Navigation
    
    @objc func navigateToMemeEditor() {
        let memeEditorViewController = storyboard?.instantiateViewController(identifier: K.VC.editMemeId) as! MemeEditorViewController
        self.navigationController?.pushViewController(memeEditorViewController, animated: true)
    }

}
