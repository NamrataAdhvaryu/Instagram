//
//  NoNotificationsView.swift
//  Instagram
//
//  Created by Namrata Akash on 19/04/21.
//

import UIKit

class NoNotificationsView: UIView {
    private let label: UILabel = {
       let label = UILabel()
        label.text = "No notifications yet"
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private let imageview : UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(systemName: "bell")
        imageview.contentMode = .scaleAspectFit
        imageview.tintColor = .secondaryLabel
        return imageview
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        addSubview(imageview)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imageview.frame = CGRect(x: (width-50)/2, y: 0, width: 50, height: 50).integral
        label.frame = CGRect(x: 0, y: imageview.bottom, width: width, height: height-50).integral
    }

}
