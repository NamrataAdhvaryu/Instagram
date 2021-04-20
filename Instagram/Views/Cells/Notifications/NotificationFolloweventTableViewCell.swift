//
//  NotificationFolloweventTableViewCell.swift
//  Instagram
//
//  Created by Namrata Akash on 19/04/21.
//
import SDWebImage
import UIKit
protocol NotificationFolloweventTableViewCelldelegate:AnyObject {
    func didTapFollowUnfollowButton(model:UserNotification)
    
}
class NotificationFolloweventTableViewCell: UITableViewCell {
    private var model:UserNotification?
    weak var delegate:NotificationFolloweventTableViewCelldelegate?
    static let identifier = "NotificationFolloweventTableViewCell"
    private let Profileimageview:UIImageView = {
    let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.backgroundColor = .tertiarySystemBackground
        imageview.layer.masksToBounds = true
        return imageview
    }()
    private let label:UILabel = {
    let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "Akash followed you"
        return label
    }()
    private let followbutton:UIButton = {
     let button = UIButton()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 4
        return button
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(followbutton)
        contentView.addSubview(Profileimageview)
        contentView.addSubview(label)
        followbutton.addTarget(self, action: #selector(didTapfollowbutton), for: .touchUpInside)
        configureforfollow()
        selectionStyle = .none
    }

   @objc private func didTapfollowbutton() {
    guard let model = model else {
        return
    }
    delegate?.didTapFollowUnfollowButton(model: model)
    }
    public func configure(with Model:UserNotification) {
        self.model = Model
      switch Model.type {
      case .like(_):
          break
    
      case .follow(let state):
        switch state {
        case .following:
            // unfollow button code
            configureforfollow()
        case .not_following:
            //follow button code
            followbutton.setTitle("follow", for: .normal)
            followbutton.setTitleColor(.white, for: .normal)
            followbutton.backgroundColor = .link
            followbutton.layer.borderWidth = 0
        }
      }
      label.text = Model.text
      Profileimageview.sd_setImage(with: model?.user.profilpicture, completed: nil)
      
  }
    private func configureforfollow() {
    followbutton.setTitle("unfollow", for: .normal)
    followbutton.setTitleColor(.label, for: .normal)
    followbutton.layer.borderWidth = 1
    followbutton.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        followbutton.setTitle(nil, for: .normal)
        followbutton.backgroundColor = nil
        followbutton.layer.borderWidth = 0
        label.text = nil
        Profileimageview.image = nil
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        Profileimageview.frame = CGRect(x: 3, y: 3, width: contentView.height-6, height: contentView.height-6)
        Profileimageview.layer.cornerRadius = Profileimageview.height/2
        
        let size:CGFloat = 100
        let buttonheight:CGFloat = 40
        followbutton.frame = CGRect(x: contentView.width-5-size, y: (contentView.height-buttonheight)/2, width: size, height: buttonheight)
        
        
        label.frame = CGRect(x: Profileimageview.right+5, y: 0, width: contentView.width-size-Profileimageview.width-16, height: contentView.height)
    }
}
