//
//  ProfiletabCollectionReusableView.swift
//  Instagram
//
//  Created by Namrata Akash on 15/04/21.
//

import UIKit

class ProfiletabCollectionReusableView: UICollectionReusableView {
   static var identifier = "ProfiletabCollectionReusableView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
