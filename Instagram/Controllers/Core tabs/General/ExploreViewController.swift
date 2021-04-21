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
        searchbar.placeholder = "search"
        
        searchbar.isUserInteractionEnabled = true
        return searchbar
    }()
    private var models = [userPost]()
    private let collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .vertical
        viewLayout.minimumLineSpacing = 1
        viewLayout.minimumInteritemSpacing = 1
        viewLayout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
        let size = 136
        viewLayout.itemSize = CGSize(width: size, height: size)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
      
        return collectionView
    }()
    private let dimmedView:UIView = {
     let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        view.isHidden = true
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        
        navigationController?.navigationBar.topItem?.titleView = searchbar
        
        
        view.backgroundColor = .systemBackground
        
        collectionView.delegate = self
        collectionView.dataSource = self
 collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        
        view.addSubview(collectionView)
        searchbar.delegate = self
        
        view.addSubview(dimmedView)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapcancelsearch))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouches = 1
        view.addSubview(gesture)
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
        dimmedView.frame = view.bounds
    }
    
    
}
extension ExploreViewController:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else {
            
            return UICollectionViewCell()
        }
        cell.configure(debug: "nam5")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let user = User(username: "namrata", bio: "", profilpicture: URL(string: "http://www.google.com")!, name: (first: "", last: ""), birthdate: Date(), gender: .female, counts: Usercount(following: 1, follwers: 1, posts: 1), joinDate: Date())
        let post = userPost(identifier: "", postType: .photo, thumbnailimage: URL(string: "http://www.google.com")!, postURL: URL(string: "http://www.google.com")!, caption: "", likecount: [], commnents: [], createddate: Date(), taggedUsers: [],owner:user)
        let vc = PostViewController(model: post)
        vc.title = post.postType.rawValue
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ExploreViewController:UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchbar.resignFirstResponder()
        guard let text = searchbar.text, !text.isEmpty else {
            return
        }
        query(text)
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchbar.becomeFirstResponder()
        didTapcancelsearch()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "cancel", style: .plain, target: self, action: #selector(didTapcancelsearch))
        
        dimmedView.isHidden = false
        UIView.animate(withDuration: 0.2) {
            self.dimmedView.alpha = 0.4
        }
    }
    @objc func didTapcancelsearch() {
        searchbar.resignFirstResponder()
        navigationItem.rightBarButtonItem = nil
        UIView.animate(withDuration: 0.2,animations: {
            self.dimmedView.alpha = 0
        }) { done in
            if done {
                self.dimmedView.isHidden = true
            }
        }
        
    }
    func query(_ text:String) {
        // perform search in the backend
    }
  
}
