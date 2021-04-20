//
//  ProfiletabCollectionReusableView.swift
//  Instagram
//
//  Created by Namrata Akash on 15/04/21.
//

import UIKit
protocol ProfiletabCollectionReusableViewdelegate:AnyObject {
    func didtapgriddedbuttonTab()
    func didtaptaggedbuttonTab()
    
}
class ProfiletabCollectionReusableView: UICollectionReusableView {
    public weak var delegate:ProfiletabCollectionReusableViewdelegate?
    static var identifier = "ProfiletabCollectionReusableView"
    struct Constants {
        static let padding:CGFloat = 8
    }
    private let gridbutton :UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .systemBlue
        button.setBackgroundImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
        return button
    }()
    
    private let taggedbutton :UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .lightGray
        button.setBackgroundImage(UIImage(systemName: "tag"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(gridbutton)
        addSubview(taggedbutton)
        
        gridbutton.addTarget(self, action: #selector(didtapgridbutton), for: .touchUpInside)
        taggedbutton.addTarget(self, action: #selector(didtaptaggedbutton), for: .touchUpInside)
    }
    @objc  private func didtapgridbutton(){
        gridbutton.tintColor = .systemBlue
        taggedbutton.tintColor = .lightGray
        delegate?.didtapgriddedbuttonTab()
        
    }
    @objc private func didtaptaggedbutton(){
        gridbutton.tintColor = .lightGray
        taggedbutton.tintColor = .systemBlue
        delegate?.didtaptaggedbuttonTab()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = height - (Constants.padding * 2)
        let gridbuttonx = ((width/2)-size)/2
        gridbutton.frame = CGRect(x: gridbuttonx,
                                  y: Constants.padding,
                                  width: size,
                                  height: size)
        taggedbutton.frame = CGRect(x: gridbuttonx + (width/2),
                                    y: Constants.padding,
                                  width: size,
                                  height: size)
    }
}
