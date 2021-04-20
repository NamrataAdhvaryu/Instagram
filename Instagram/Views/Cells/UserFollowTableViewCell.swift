//
//  UserFollowTableViewCell.swift
//  Instagram
//
//  Created by Namrata Akash on 16/04/21.
//

import UIKit


protocol UserFollowTableViewCellDelegate: AnyObject {
    func  didTapFollowUnfollowButton(model: UserRelationship)
}

enum FollowState {
    case following, not_following
}

public struct UserRelationship {
    let username:String
    let name:String
    let type:FollowState
}

class UserFollowTableViewCell: UITableViewCell {
    weak var delegate:UserFollowTableViewCellDelegate?
    static let identifier = "UserFollowTableViewCell"
    private var model : UserRelationship?
    
    
    private let ProfileImageview: UIImageView = {
        let imageview = UIImageView()
        imageview.layer.masksToBounds = true
        imageview.backgroundColor = .secondarySystemBackground
        imageview.contentMode = .scaleAspectFill
        return imageview
    }()
    
    private let namelabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Namrata"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    
    private let usernamelabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "@namrata"
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let followbutton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .link
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(usernamelabel)
        contentView.addSubview(namelabel)
        contentView.addSubview(ProfileImageview)
        contentView.addSubview(followbutton)
        selectionStyle = .none
        followbutton.addTarget(self, action: #selector(didTapfollowbutton), for: .touchUpInside)
    }
    @objc private func didTapfollowbutton() {
        guard let model = model else {
            return
        }
        delegate?.didTapFollowUnfollowButton(model: model)
        
        
    }
    
    public func Configure(with model:UserRelationship)
    {
        self.model = model
        namelabel.text = model.name
        usernamelabel.text = model.username
        switch model.type {
        case .following:
            // show unfollow button
            followbutton.setTitle("Unfollow", for: .normal)
            followbutton.backgroundColor = .systemBackground
            followbutton.setTitleColor(.label, for: .normal)
            followbutton.layer.borderWidth = 1
            followbutton.layer.borderColor = UIColor.label.cgColor
        case .not_following:
            // show follow button
        followbutton.setTitle("Follow", for: .normal)
            followbutton.backgroundColor = .link
        followbutton.setTitleColor(.white, for: .normal)
        followbutton.layer.borderWidth = 0
        
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        usernamelabel.text = nil
        ProfileImageview.image = nil
        namelabel.text = nil
        followbutton.setTitle(nil, for: .normal)
        followbutton.layer.borderWidth = 0
        followbutton.backgroundColor = nil
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        ProfileImageview.frame = CGRect(x: 3 ,
                                        y: 3,
                                        width: contentView.height-6,
                                        height: contentView.height-6)
        ProfileImageview.layer.cornerRadius = ProfileImageview.height/2
        
        
        let buttonwidth = contentView.width > 500 ? 220.0 : contentView.width/3
        followbutton.frame = CGRect(x: contentView.width-5-buttonwidth,
                                    y: (contentView.height-40)/2 ,
                                    width: buttonwidth,
                                    height: 40)
        
        let labelheight = contentView.height/2
        namelabel.frame = CGRect(x: ProfileImageview.right+5,
                                 y: 0,
                                 width: contentView.width-8-ProfileImageview.width-buttonwidth,
                                 height: labelheight)
        usernamelabel.frame = CGRect(x: ProfileImageview.right+5,
                                     y: namelabel.bottom,
                                     width: contentView.width-8-ProfileImageview.width-buttonwidth,
                                     height: labelheight)
        
    }
    
}
