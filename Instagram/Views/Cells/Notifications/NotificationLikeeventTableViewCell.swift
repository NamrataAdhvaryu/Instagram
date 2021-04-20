//
//  NotificationLikeeventTableViewCell.swift
//  Instagram
//
//  Created by Namrata Akash on 19/04/21.
//
import SDWebImage
import UIKit
protocol NotificationLikeeventTableViewCelldelegate:AnyObject {
    func didTapRelatedLikeButton(model:UserNotification)
    
}
class NotificationLikeeventTableViewCell: UITableViewCell {
    private var model:UserNotification?
    weak var delegate:NotificationLikeeventTableViewCelldelegate?
    static let identifier = "NotificationLikeeventTableViewCell"
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
        label.text = "@Namrata liked your photo"
        label.numberOfLines = 0
        return label
    }()
    private let Postbutton:UIButton = {
     let button = UIButton()
        button.setBackgroundImage(UIImage(named: "nam5"), for: .normal)
        return button
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(Postbutton)
        contentView.addSubview(Profileimageview)
        contentView.addSubview(label)
        Postbutton.addTarget(self, action: #selector(didTapPostbutton), for: .touchUpInside)
        selectionStyle = .none
    }
    
   @objc private func didTapPostbutton() {
    guard let model = model else {
        return
    }
    delegate?.didTapRelatedLikeButton(model: model)
    }
    public func configure(with Model:UserNotification) {
        self.model = Model
      switch Model.type {
      case .like(let post):
          break
          let thumbnail = post.thumbnailimage
        guard !thumbnail.absoluteString.contains("google.com") else {
            return
        }
        Postbutton.sd_setBackgroundImage(with: thumbnail, for: .normal, completed: nil)
      case .follow:
          break
      }
      label.text = Model.text
      Profileimageview.sd_setImage(with: model?.user.profilpicture, completed: nil)
      
  }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        Postbutton.setBackgroundImage(nil, for: .normal)
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
        
        let size = contentView.height-4
        Postbutton.frame = CGRect(x: contentView.width-5-size, y: 2, width: size, height: size)
        label.frame = CGRect(x: Profileimageview.right+5, y: 0, width: contentView.width-size-Profileimageview.width-16, height: contentView.height)
    }
}
