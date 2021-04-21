//
//  IGFeedPostTableViewCell.swift
//  Instagram
//
//  Created by Namrata Akash on 14/04/21.
//
import SDWebImage
import UIKit
import AVFoundation



//cell for primary post content

class IGFeedPostTableViewCell: UITableViewCell {
static let identifier = "IGFeedPostTableViewCell"
    private let postimageview:UIImageView = {
     let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.backgroundColor = nil
        imageview.clipsToBounds = true
        return imageview
    }()
    
    
    private var player:AVPlayer?
    private var playerlayer = AVPlayerLayer()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.layer.addSublayer(playerlayer)
        
        contentView.addSubview(postimageview)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func configure(with post:userPost) {
        //configure the cell
        postimageview.image = UIImage(named: "nam5")
        return
        switch post.postType {
        case .photo:
            postimageview.sd_setImage(with: post.postURL, completed: nil)
        case .video:
            player = AVPlayer(url: post.postURL)
            playerlayer.player = player
            playerlayer.player?.volume = 0
            playerlayer.player?.play()
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        playerlayer.frame = contentView.bounds
        postimageview.frame = contentView.bounds
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        postimageview.image = nil
    }
    
}
