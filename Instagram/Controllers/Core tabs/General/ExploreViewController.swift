//
//  ExploreViewController.swift
//  Instagram
//
//  Created by Namrata Akash on 12/04/21.
//

import UIKit

class ExploreViewController: UIViewController {
    private let searchbar: UISearchBar = {
     let searchbar = UISearchBar()
        searchbar.backgroundColor = .secondarySystemBackground
        return searchbar
    }()
    private var collectionview:UICollectionView?
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.topItem?.titleView = searchbar
        
        collectionview?.delegate = self
        collectionview?.dataSource = self
        let layout = UICollectionViewFlowLayout()
        collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
    }
    

    
}
extension ExploreViewController:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}
