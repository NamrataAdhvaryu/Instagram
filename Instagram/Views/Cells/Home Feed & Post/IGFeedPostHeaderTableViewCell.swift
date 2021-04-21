//
//  IGFeedPostHeaderTableViewCell.swift
//  Instagram
//
//  Created by Namrata Akash on 14/04/21.
//
import SDWebImage
import UIKit

protocol IGFeedPostHeaderTableViewCelldelegate:AnyObject {
    func didTapmorebutton()
}


class IGFeedPostHeaderTableViewCell: UITableViewCell {
    weak var delegate:IGFeedPostHeaderTableViewCelldelegate?
    static let identifier = "IGFeedPostHeaderTableViewCell"
        
    
    private let profilephotoimageview:UIImageView = {
     let imageview = UIImageView()
        imageview.clipsToBounds = true
        imageview.layer.masksToBounds = true
        imageview.contentMode = .scaleAspectFill
        return imageview
    }()
    
    
    private let usernamelabel:UILabel = {
     let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    
    private let moreButton:UIButton = {
     let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        return button
    }()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            contentView.addSubview(profilephotoimageview)
            contentView.addSubview(moreButton)
            contentView.addSubview(usernamelabel)
            moreButton.addTarget(self, action: #selector(didTapbutton), for: .touchUpInside)
//            contentView.backgroundColor = .systemBlue
        }
 @objc private func didTapbutton() {
    delegate?.didTapmorebutton()
    }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    public func configure(with model:User) {
            //configure the cell
        usernamelabel.text = model.username
        profilephotoimageview.image = UIImage(systemName: "person.circle")
//        profilephotoimageview.sd_setImage(with: model.profilpicture, completed: nil)
        }
        override func layoutSubviews() {
            super.layoutSubviews()
            let size = contentView.height - 4
            profilephotoimageview.frame = CGRect(x: 2, y: 2, width: size, height: size)
            profilephotoimageview.layer.cornerRadius = size/2
            
            moreButton.frame = CGRect(x: contentView.width-size, y: 2, width: size, height: size)
            usernamelabel.frame = CGRect(x: profilephotoimageview.right+10, y: 2, width: contentView.width-(size*2)-15, height: contentView.height-4)
            
            
            
        }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        usernamelabel.text = nil
        profilephotoimageview.image = nil
    }

}
