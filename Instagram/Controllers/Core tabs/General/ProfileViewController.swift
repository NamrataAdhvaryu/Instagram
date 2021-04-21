//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Namrata Akash on 12/04/21.
//

import UIKit

class ProfileViewController: UIViewController {
    var Userpost = [userPost]()
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .systemBackground
        configurenavigationbar()
        collectionView.delegate = self
        collectionView.dataSource = self
 collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        
        

    
        //headers
        
        collectionView.register(ProfileinfoHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileinfoHeaderCollectionReusableView.identifier)
        collectionView.register(ProfiletabCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfiletabCollectionReusableView.identifier)
        
        
        view.addSubview(collectionView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
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




extension ProfileViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }
        //Userpost.count
        return 30
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
//        let model = Userpost[indexPath.row]
//        cell.configure(with: model)
        cell.configure(debug: "nam5")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var model = Userpost[indexPath.row]
        let user = User(username: "namrata", bio: "", profilpicture: URL(string: "http://www.google.com")!, name: (first: "", last: ""), birthdate: Date(), gender: .female, counts: Usercount(following: 1, follwers: 1, posts: 1), joinDate: Date())
        let post = userPost(identifier: "", postType: .photo, thumbnailimage: URL(string: "http://www.google.com")!, postURL: URL(string: "http://www.google.com")!, caption: "", likecount: [], commnents: [], createddate: Date(), taggedUsers: [],owner:user)
        let vc = PostViewController(model: post)
        vc.title = post.postType.rawValue
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionHeader  else {
            //footer
            return UICollectionReusableView()
        }
        
        if indexPath.section == 1 {
            let tabcontrolheader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfiletabCollectionReusableView.identifier, for: indexPath) as! ProfiletabCollectionReusableView
            tabcontrolheader.delegate = self
        return tabcontrolheader
        }
        let profileheader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileinfoHeaderCollectionReusableView.identifier, for: indexPath) as! ProfileinfoHeaderCollectionReusableView
        profileheader.delegate = self
        return profileheader
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.width, height: collectionView.height/3)
        }
        return CGSize(width: collectionView.width, height: 50)
    }

}
// MARK :- ProfileinfoHeaderCollectionReusableViewdelegate
extension ProfileViewController: ProfileinfoHeaderCollectionReusableViewdelegate {
    func profileheaderDidTapPostsButton(_ Header: ProfileinfoHeaderCollectionReusableView) {
        // scroll to the post
        collectionView.scrollToItem(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
    }
    
    func profileheaderDidTapfollwingButton(_ Header: ProfileinfoHeaderCollectionReusableView) {
        
        var mockdata = [UserRelationship]()
        for x in 0..<10 {
            mockdata.append(UserRelationship(username: "namrata", name: "namrata joshi", type: x % 2 == 0 ? .following:.not_following))
        }
        let vc = ListViewController(data: mockdata)
        vc.title = "Following"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func profileheaderDidTapfollowersButton(_ Header: ProfileinfoHeaderCollectionReusableView) {
        var mockdata = [UserRelationship]()
        for x in 0..<10 {
            mockdata.append(UserRelationship(username: "namrata", name: "namrata joshi", type: x % 2 == 0 ? .following:.not_following))
        }
        let vc = ListViewController(data: mockdata)
        vc.title = "followers"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func profileheaderDidTapeditprofileButton(_ Header: ProfileinfoHeaderCollectionReusableView) {
      let vc = EditprofileViewController()
        vc.title = "Edit Profile"
        present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    

}
//
extension ProfileViewController: ProfiletabCollectionReusableViewdelegate {
    func didtapgriddedbuttonTab() {
        
    }
    
    func didtaptaggedbuttonTab() {
        
    }
    
    
}
