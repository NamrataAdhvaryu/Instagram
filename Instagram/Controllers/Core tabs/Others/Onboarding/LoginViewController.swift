//
//  LoginViewController.swift
//  Instagram
//
//  Created by Namrata Akash on 12/04/21.
//

import UIKit

class LoginViewController: UIViewController {

    private let usernameemailtextfield: UITextField = {
        return UITextField()
    }()
    
    private let passwordtextfield: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        return field
    }()
    
    private let loginButton:UIButton = {
        return UIButton()
    }()
    private let privacyButton:UIButton = {
        return UIButton()
    }()
    private let termsButton:UIButton = {
        return UIButton()
    }()
    private let createAccountButton:UIButton = {
        return UIButton()
    }()
    private let headerView :UIView = {
        return UIView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
addsubview()
        view.backgroundColor = .systemBackground
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        // frames
        
        
    }
    private func addsubview() {
        view.addSubview(usernameemailtextfield)
        view.addSubview(passwordtextfield)
        view.addSubview(loginButton)
        view.addSubview(privacyButton)
        view.addSubview(termsButton)
        view.addSubview(headerView)
        view.addSubview(createAccountButton)
        
    }
    
    @objc private func didTapLoginButton() {}
    @objc private func didTapPrivacyButton() {}
    @objc private func didTapTermsButton() {}
    @objc private func didTapCreateAccountButton() {}
    

    
  

}
