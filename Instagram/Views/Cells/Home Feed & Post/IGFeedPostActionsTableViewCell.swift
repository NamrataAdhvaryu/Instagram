//
//  IGFeedPostActionsTableViewCell.swift
//  Instagram
//
//  Created by Namrata Akash on 14/04/21.
//

import UIKit
protocol IGFeedPostActionsTableViewCelldelegate:AnyObject {
    func didtapLikeButton()
    func didtapCommentButton()
    func didtapShareButton()
    
    
}
class IGFeedPostActionsTableViewCell: UITableViewCell {

    static let identifier = "IGFeedPostActionsTableViewCell"
    weak var delegate:IGFeedPostActionsTableViewCelldelegate?
    private let likebutton:UIButton = {
     let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
        let image = UIImage(systemName: "heart", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let commentbutton:UIButton = {
     let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
        let image = UIImage(systemName: "message", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let sharebutton:UIButton = {
     let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
        let image = UIImage(systemName: "paperplane", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            contentView.addSubview(likebutton)
            contentView.addSubview(commentbutton)
            contentView.addSubview(sharebutton)
            likebutton.addTarget(self, action: #selector(didTaplikebutton), for: .touchUpInside)
            commentbutton.addTarget(self, action: #selector(didTapcommentbutton), for: .touchUpInside)
            sharebutton.addTarget(self, action: #selector(didTapsharebutton), for: .touchUpInside)
        }
    
    
    @objc private func didTaplikebutton() {
        delegate?.didtapLikeButton()
    }
    @objc private func didTapcommentbutton() {
        delegate?.didtapCommentButton()
    }
    @objc private func didTapsharebutton() {
        delegate?.didtapShareButton()
    }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        public func configure() {
            //configure the cell
        }
        override func layoutSubviews() {
            super.layoutSubviews()
            // like comment share
            
            let buttonsize = contentView.height-10
            
            let button = [likebutton,commentbutton,sharebutton]
            for x in 0..<button.count {
                let button = button[x]
                button.frame = CGRect(x: (CGFloat(x)*buttonsize) + (10*CGFloat(x+1)), y: 5, width: buttonsize, height: buttonsize)
            }
        }
        

}
