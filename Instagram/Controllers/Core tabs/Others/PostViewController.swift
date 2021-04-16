//
//  PostViewController.swift
//  Instagram
//
//  Created by Namrata Akash on 12/04/21.
//

import UIKit

class PostViewController: UIViewController {
    private let model : userPost?
    private let tableview : UITableView = {
      let tableview = UITableView()
        return tableview
    }()
    init(model: userPost?) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
override func viewDidLoad() {
        super.viewDidLoad()
    view.backgroundColor = .systemBackground
    view.addSubview(tableview)
    tableview.delegate = self
    tableview.dataSource = self
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableview.frame = view.bounds
    }
    


    
}
extension PostViewController:UITableViewDelegate,UITableViewDataSource  {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
    }
}
