//
//  NotificationsViewController.swift
//  Instagram
//
//  Created by Namrata Akash on 12/04/21.
//

import UIKit

class NotificationsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    private let tableview : UITableView = {
      let tableview = UITableView()
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableview
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
       title = "Notifications"
        view.addSubview(tableview)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableview.frame = view.bounds
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}
