//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Jon Sweeney on 3/31/21.
//

import UIKit

class SentMemesTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var memes: [Meme]! {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.memes
    }
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.separatorStyle = .none
        tableView.rowHeight = 80.0
        tabBarController?.tabBar.isHidden = false
        navigationController?.isNavigationBarHidden = false
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.Cell.tableViewReuseId, for: indexPath) as! MemeTableViewCell
        let meme = memes[indexPath.row]
        
        cell.cellTopLabel.text = meme.textTop
        cell.cellBottomLabel.text = meme.textBottom
        cell.cellImageView.image = meme.imageEdited
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMeme = memes[indexPath.row]
        
        if let memeDetailVC = storyboard?.instantiateViewController(identifier: K.VC.detailMemeId) as? MemeDetailViewController {
            memeDetailVC.detailMeme = selectedMeme
            navigationController?.pushViewController(memeDetailVC, animated: true)
        }
    }
}
