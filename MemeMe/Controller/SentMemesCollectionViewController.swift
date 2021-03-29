//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Jon Sweeney on 3/28/21.
//

import UIKit

private let reuseIdentifier = "Cell"

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

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let rtBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(navigateToMemeEditor))
        navigationItem.setRightBarButton(rtBarButtonItem, animated: animated)
        collectionView.reloadData()
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        print("Memes count: \(memes.count)")
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.Cell.reuseId, for: indexPath) as! MemeCollectionViewCell
    
        // Configure the cell
        if let image = cell.imageView {
            image.image = memes[indexPath.row].imageEdited
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let memeDetailVC
    }

    // MARK: Navigation
    
    @objc func navigateToMemeEditor() {
        let memeEditorViewController = storyboard?.instantiateViewController(identifier: K.VC.editMemeId) as! MemeEditorViewController
        self.present(memeEditorViewController, animated: true, completion: nil)
    }

}
