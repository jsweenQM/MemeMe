//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Jon Sweeney on 3/28/21.
//

import UIKit

class SentMemesCollectionViewController: UICollectionViewController {

    // MARK: Properties
    
    var memes: [Meme]! {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.memes
    }
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    // MARK: Methods
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setCellDimensions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let rtBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(navigateToMemeEditor))
        navigationItem.setRightBarButton(rtBarButtonItem, animated: animated)
        collectionView.reloadData()
        tabBarController?.tabBar.isHidden = false
    }

    // MARK: UI
    
    fileprivate func setCellDimensions() {
        let space: CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.Cell.collectionViewReuseId, for: indexPath) as! MemeCollectionViewCell
        let meme = memes[(indexPath as NSIndexPath).row]
        cell.imageView?.image = meme.imageEdited
        
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
