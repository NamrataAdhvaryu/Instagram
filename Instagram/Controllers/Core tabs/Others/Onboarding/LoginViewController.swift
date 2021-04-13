//
//  LoginViewController.swift
//  Instagram
//
//  Created by Namrata Akash on 12/04/21.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {
    struct  Constants {
        static var cornerradius:CGFloat = 8.0
    }
    private let usernameemailtextfield: UITextField = {
        let field = UITextField()
        field.placeholder = "username or Email...."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerradius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let passwordtextfield: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Password..."
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerradius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let loginButton:UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerradius
        button.backgroundColor = .systemBlue
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    private let privacyButton:UIButton = {
        let button = UIButton()
        button.setTitle("Terms and Services", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    private let termsButton:UIButton = {
        let button = UIButton()
        button.setTitle("Privacy and Policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    private let createAccountButton:UIButton = {
        let button = UIButton()
        button.setTitle("New user? Create an Account", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    private let headerView :UIView = {
        let header = UIView()
        header.clipsToBounds = true
        let backgroundimageview = UIImageView(image: UIImage(named: "Gredient"))
        header.addSubview(backgroundimageview)
        return header
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.addTarget(
            self, action: #selector(didTapLoginButton), for: .touchUpInside)
        privacyButton.addTarget(
            self, action: #selector(didTapPrivacyButton), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTermsButton), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        usernameemailtextfield.delegate = self
        passwordtextfield.delegate = self
        addsubview()
        view.backgroundColor = .systemBackground
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        // frames
        
        headerView.frame = CGRect(
            x: 0,
            y: 0.0,
            width: view.width,
            height: view.height/3.0)
        
        usernameemailtextfield.frame = CGRect(
            x: 25,
            y: headerView.bottom + 40,
            width: view.width - 50,
            height: 52.0)
        
        passwordtextfield.frame = CGRect(
            x: 25,
            y: usernameemailtextfield.bottom + 10,
            width: view.width - 50,
            height: 52.0)
        loginButton.frame = CGRect(
            x: 25,
            y: passwordtextfield.bottom + 10,
            width: view.width - 50,
            height: 52.0)
        
        createAccountButton.frame = CGRect(
            x: 25,
            y: loginButton.bottom + 10,
            width: view.width - 50,
            height: 52.0)
        
        termsButton.frame = CGRect(x: 10, y: view.height - view.safeAreaInsets.bottom - 100, width: view.width - 20, height: 50)
        privacyButton.frame = CGRect(x: 10, y: view.height - view.safeAreaInsets.bottom - 50, width: view.width - 20, height: 50)
        configureheaderview()
    }
    
    func  configureheaderview()  {
        guard  headerView.subviews.count == 1 else {
            return
        }
        
        
        guard var backgroundview = headerView.subviews.first else {
            return
        }
        
        backgroundview.frame = headerView.bounds
        
        let imageview = UIImageView(image: UIImage(named: "text"))
        headerView.addSubview(imageview)
        imageview.contentMode = .scaleAspectFit
        imageview.frame = CGRect(x: headerView.width/4.0, y: view.safeAreaInsets.top, width: headerView.width/2, height: headerView.height - view.safeAreaInsets.top)
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
    
    @objc private func didTapLoginButton() {
        usernameemailtextfield.resignFirstResponder()
        passwordtextfield.resignFirstResponder()
        var username:String?
        var email:String?
        guard let useremail = usernameemailtextfield.text, !useremail.isEmpty, let password = passwordtextfield.text, !password.isEmpty,password.count >= 8  else {
            return
        }
        if useremail.contains("@"),useremail.contains(".") {
            //email
            email = useremail
        }
        else {
            username = useremail
        }
        AuthManager.shared.loginUser(username: username, email: email, password: password) { sucess in
            DispatchQueue.main.async {
                if sucess {
                    self.dismiss(animated: true, completion: nil)
                }
                else {
                    let aleart = UIAlertController(title: "Log in Error", message: "We were unable to log in.", preferredStyle: .alert)
                    aleart.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    self.present(aleart, animated: true)
                }
                
            }
            
        }
        
    }
    @objc private func didTapPrivacyButton() {
        guard let url = URL(string: "https://help.instagram.com/519522125107875") else {
            return
        }
     let vc = SFSafariViewController(url: url)
       present(vc, animated: true)
    }
    @objc private func didTapTermsButton() {
        guard let url = URL(string: "https://www.instagram.com/about/legal/terms/before-january-19-2013/") else {
            return
        }
     let vc = SFSafariViewController(url: url)
       present(vc, animated: true)
    }
    @objc private func didTapCreateAccountButton() {
        let vc = RegistrationViewController()
        vc.title = "Create Account"
        present(UINavigationController(rootViewController:vc), animated: true, completion: nil)
    }
    
    
    
    
    
}
extension LoginViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameemailtextfield {
            textField.becomeFirstResponder()
        }
        else if textField == passwordtextfield {
            didTapLoginButton()
        }
        return true
    }
    
}
