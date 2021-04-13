//
//  RegistrationViewController.swift
//  Instagram
//
//  Created by Namrata Akash on 12/04/21.
//

import UIKit

class RegistrationViewController: UIViewController {
    struct  Constants {
        static var cornerradius:CGFloat = 8.0
    }
    private let usernamefield: UITextField = {
        let field = UITextField()
        field.placeholder = "username...."
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
    
    private let emailfield: UITextField = {
        let field = UITextField()
        field.placeholder = "email...."
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
    
    private let passwordfield: UITextField = {
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
    
    private let RegisterButton:UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerradius
        button.backgroundColor = .systemGreen
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        RegisterButton.addTarget(self, action: #selector(didtapregisterbutton), for: .touchUpInside)
        usernamefield.delegate = self
        passwordfield.delegate = self
        emailfield .delegate = self
        view.backgroundColor = .black
        view.addSubview(emailfield)
        view.addSubview(passwordfield)
        view.addSubview(usernamefield)
        view.addSubview(RegisterButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        usernamefield.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 100, width: view.width - 40, height: 52)
        emailfield.frame = CGRect(x: 20, y: usernamefield.bottom + 10, width: view.width - 40, height: 52)
        passwordfield.frame = CGRect(x: 20, y: emailfield.bottom + 10, width: view.width - 40, height: 52)
        RegisterButton.frame = CGRect(x: 20, y: passwordfield.bottom + 10, width: view.width - 40, height: 52)
        
    }
    @objc  private func didtapregisterbutton() {
        usernamefield.resignFirstResponder()
        passwordfield.resignFirstResponder()
        emailfield.resignFirstResponder()
        guard let username = usernamefield.text, !username.isEmpty,
              let email = emailfield.text, !email.isEmpty, email.count >= 8,
              let password = passwordfield.text,!password.isEmpty  else {
            return
        }
        AuthManager.shared.registerNewUser(username: username, email: email, password: password, completion: {
            registerded in
            if registerded {
                
            }
            else{
                
            }
        })
        
    }
   
}
extension RegistrationViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernamefield {
            emailfield.becomeFirstResponder()
        }
        else if textField == emailfield {
            passwordfield.becomeFirstResponder()
        }
        else{
            didtapregisterbutton()
        }
        return true
    }
}
