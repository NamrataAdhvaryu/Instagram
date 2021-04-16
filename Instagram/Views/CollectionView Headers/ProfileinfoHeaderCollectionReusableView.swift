//
//  ProfileinfoHeaderCollectionReusableView.swift
//  Instagram
//
//  Created by Namrata Akash on 15/04/21.
//

import UIKit
protocol ProfileinfoHeaderCollectionReusableViewdelegate:AnyObject {
    func profileheaderDidTapPostsButton(_ Header:ProfileinfoHeaderCollectionReusableView)
    func profileheaderDidTapfollwingButton(_ Header:ProfileinfoHeaderCollectionReusableView)
    func profileheaderDidTapfollowersButton(_ Header:ProfileinfoHeaderCollectionReusableView)
    func profileheaderDidTapeditprofileButton(_ Header:ProfileinfoHeaderCollectionReusableView)
}
final class ProfileinfoHeaderCollectionReusableView: UICollectionReusableView {
    public weak var delegate: ProfileinfoHeaderCollectionReusableViewdelegate?
   static var identifier = "ProfileinfoHeaderCollectionReusableView"
    private let Profilephotoimageview:UIImageView = {
       let imageview = UIImageView()
        imageview.backgroundColor = .red
        imageview.layer.masksToBounds = true
        return imageview
    }()
    
    private let Postbutton:UIButton = {
        let postbutton = UIButton()
        postbutton.setTitleColor(.label, for: .normal)
        postbutton.backgroundColor = .secondarySystemBackground
        postbutton.setTitle("Posts", for: .normal)
        return postbutton
    }()
    private let followingbutton:UIButton = {
     let followingbutton = UIButton()
        followingbutton.setTitleColor(.label, for: .normal)
        followingbutton.backgroundColor = .secondarySystemBackground
        followingbutton.setTitle("Following", for: .normal)
        return followingbutton
    }()
    
    
    private let followersbutton :UIButton = {
    let followersbutton = UIButton()
        followersbutton.setTitleColor(.label, for: .normal)
        followersbutton.backgroundColor = .secondarySystemBackground
        followersbutton.setTitle("Followers", for: .normal)
    return followersbutton
    }()
    
    private let editprofilebutton:UIButton = {
      let editprofilebutton = UIButton()
        editprofilebutton.setTitleColor(.label, for: .normal)
        editprofilebutton.backgroundColor = .secondarySystemBackground
        editprofilebutton.setTitle("Edit Your Profile", for: .normal)
        return editprofilebutton
    }()
    
    private let namelabel : UILabel = {
      let namelabel = UILabel()
        namelabel.text = "Namrata Joshi"
        namelabel.textColor = .label
        namelabel.numberOfLines = 1
        return namelabel
    }()
    
    private let biolabel:UILabel = {
      let biolabel = UILabel()
        biolabel.text = "Living a blessed Life!"
        biolabel.numberOfLines = 0 // lines wrap
        biolabel.textColor = .label
        return biolabel
    }()
    
    
    // MARK :- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addsubviews()
        addbuttonactions()
        backgroundColor = .systemBackground
        clipsToBounds = true
    }
    func addsubviews() {
        addSubview(Profilephotoimageview)
        addSubview(Postbutton)
        addSubview(editprofilebutton)
        addSubview(followersbutton)
        addSubview(followingbutton)
        addSubview(namelabel)
        addSubview(biolabel)
    }
    public func addbuttonactions() {
        Postbutton.addTarget(self, action: #selector(didtappostbutton), for: .touchUpInside)
        followingbutton.addTarget(self, action: #selector(didtapfollowingbutton), for: .touchUpInside)
        followersbutton.addTarget(self, action: #selector(didtapfollowersbutton), for: .touchUpInside)
        editprofilebutton.addTarget(self, action: #selector(didtapeditprofilebutton), for: .touchUpInside)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
let profilephotosize = width/4
        
        Profilephotoimageview.frame = CGRect(
            x: 5,
            y: 5,
            width: profilephotosize,
            height: profilephotosize).integral
        Profilephotoimageview.layer.cornerRadius = profilephotosize/2.0
        
        let buttonsize = profilephotosize/2
        let countbuttonwidth = (width-10-profilephotosize)/3
        
        Postbutton.frame = CGRect(
            x: Profilephotoimageview.right,
            y: 5,
            width: countbuttonwidth,
            height: buttonsize).integral
        followersbutton.frame = CGRect(
            x: Postbutton.right,
            y: 5,
            width: countbuttonwidth,
            height: buttonsize).integral
        followingbutton.frame = CGRect(
            x: followersbutton.right,
            y: 5,
            width: countbuttonwidth,
            height: buttonsize).integral
        
        editprofilebutton.frame = CGRect(
            x: Profilephotoimageview.right,
            y: 5 + buttonsize,
            width: countbuttonwidth*3,
            height: buttonsize).integral
        
        namelabel.frame = CGRect(
            x: 5,
            y: Profilephotoimageview.bottom,
            width: width-10,
            height: 50).integral
        let biolabelsize = biolabel.sizeThatFits(frame.size)
        biolabel.frame = CGRect(
            x: 5,
            y: 5 + namelabel.bottom,
            width: width-10,
            height: biolabelsize.height).integral
    }
// MARK :- button Actions
    @objc func didtappostbutton() {
        delegate?.profileheaderDidTapPostsButton(self)
    }
    @objc func didtapfollowingbutton() {
        delegate?.profileheaderDidTapfollwingButton(self)
    }
    @objc func didtapfollowersbutton() {
        delegate?.profileheaderDidTapfollowersButton(self)
    }
    @objc func didtapeditprofilebutton() {
        delegate?.profileheaderDidTapeditprofileButton(self)
    }
    
    
}
