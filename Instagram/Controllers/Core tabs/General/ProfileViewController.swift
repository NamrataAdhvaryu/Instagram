//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Namrata Akash on 12/04/21.
//

import UIKit

class ProfileViewController: UIViewController {
    private var collectionview :UICollectionView?
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionview?.delegate = self
        collectionview?.dataSource = self
        configurenavigationbar()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.width/3, height: view.width/3)
        collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionview = collectionview else {
            return
        }
        
        
        view.addSubview(collectionview)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionview?.frame = view.bounds
    }
  private  func configurenavigationbar()  {
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),style: .done, target: self, action: #selector(didtapsettingsButton))
    }
  @objc func didtapsettingsButton()
   {
    let vc = SettingsViewController()
    vc.title = ""
    navigationController?.pushViewController(vc, animated: true)
   }
    
    }
    
extension ProfileViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionview?.deselectItem(at: indexPath, animated: true)
    }
    
}

