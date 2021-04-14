//
//  ViewController.swift
//  Instagram
//
//  Created by Namrata Akash on 12/04/21.
//

import UIKit
import FirebaseAuth
class HomeViewController: UIViewController {
    private var tableview:UITableView = {
       let tableview = UITableView()
        tableview.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        return tableview
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableview)
        tableview.delegate = self
        tableview.dataSource = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableview.frame = view.bounds
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
extension HomeViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
        return cell
    }
    
    
}
