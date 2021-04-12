//
//  ViewController.swift
//  Instagram
//
//  Created by Namrata Akash on 12/04/21.
//

import UIKit
import FirebaseAuth
class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handlenotautheniticated()
    }
        
       
     private func handlenotautheniticated() {
            //check auth status
            if Auth.auth().currentUser == nil {
              let loginVC = LoginViewController()
                loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
                
            }
        
    }

}

