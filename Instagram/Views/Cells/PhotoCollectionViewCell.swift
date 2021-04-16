//
//  PhotoCollectionViewCell.swift
//  Instagram
//
//  Created by Namrata Akash on 15/04/21.
//
import SDWebImage
import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
   static let identifier = "PhotoCollectionViewCell"
   
    private let photoimageview : UIImageView = {
     let imageview = UIImageView()
        imageview.clipsToBounds = true
        imageview.contentMode = .scaleAspectFill
        return imageview
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoimageview.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoimageview.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(photoimageview)
        accessibilityLabel = "User post image"
        accessibilityHint = "Double tap to open Post"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func configure(with model: userPost) {
        let url = model.thumbnailimage
        photoimageview.sd_setImage(with: url, completed: nil)
        
    }
    public func configure(debug imagename:String) {
        photoimageview.image = UIImage(named: imagename)
    }
    
    
}
