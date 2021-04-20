//
//  NotificationsViewController.swift
//  Instagram
//
//  Created by Namrata Akash on 12/04/21.
//

import UIKit

enum UserNotificationsType {
    case like(post:userPost)
    case follow(state: FollowState)
}
struct UserNotification {
    let type: UserNotificationsType
    let text:String
    let user:User
}
final class NotificationsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    private let tableview : UITableView = {
      let tableview = UITableView()
        tableview.isHidden = false
        tableview.register(NotificationLikeeventTableViewCell.self, forCellReuseIdentifier: NotificationLikeeventTableViewCell.identifier)
        tableview.register(NotificationFolloweventTableViewCell.self, forCellReuseIdentifier: NotificationFolloweventTableViewCell.identifier)
        return tableview
    }()
    private let spinner:UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.tintColor = .label
        return spinner
    }()
    private lazy var noNotificationView = NoNotificationsView()
    
    private var modals = [UserNotification]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        fetchnotifications()
        view.addSubview(spinner)
        view.backgroundColor = .systemBackground
//        spinner.startAnimating()
        tableview.delegate = self
        tableview.dataSource = self
        navigationItem.title = "Notifications"
      view.addSubview(tableview)
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableview.frame = view.bounds
        spinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        spinner.center = view.center
    }
    private func layoutnotificationView() {
        tableview.isHidden = true
        view.addSubview(noNotificationView)
        noNotificationView.frame = CGRect(x: 0, y: 0, width: view.width/2, height: view.width/4)
        noNotificationView.center = view.center
    }
    private func fetchnotifications() {
        for x in 0...100 {
            let post = userPost(identifier: "", postType: .photo, thumbnailimage: URL(string: "http://www.google.com")!, postURL: URL(string: "http://www.google.com")!, caption: "", likecount: [], commnents: [], createddate: Date(), taggedUsers: [])
            let model = UserNotification(type: x % 2 == 0 ? .like(post:post) : .follow(state:.not_following), text: "namrata likes your photo", user: User(username: "namrata", bio: "", profilpicture: URL(string: "http://www.google.com")!, name: (first: "", last: ""), birthdate: Date(), gender: .female, counts: Usercount(following: 1, follwers: 1, posts: 1), joinDate: Date()))
            modals.append(model)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modals.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = modals[indexPath.row]
        switch model.type {
        case .like(_):
            let cell = tableview.dequeueReusableCell(withIdentifier: NotificationLikeeventTableViewCell.identifier, for: indexPath) as! NotificationLikeeventTableViewCell
            cell.configure(with: model)
            cell.delegate = self
            return cell
        case .follow:
            
            let cell = tableview.dequeueReusableCell(withIdentifier: NotificationFolloweventTableViewCell.identifier, for: indexPath) as! NotificationFolloweventTableViewCell
            cell.delegate = self
//            cell.configure(with: model)
            return cell
        }
        
       
   
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
}
extension NotificationsViewController:NotificationLikeeventTableViewCelldelegate {
    func didTapRelatedLikeButton(model:UserNotification) {
        switch model.type {
        
        case .like(let post):
          let vc = PostViewController(model: post)
            vc.title = post.postType.rawValue
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
        case .follow(_):
            fatalError("Devissue:should never called")
        }
    }
    
    
}
extension NotificationsViewController:NotificationFolloweventTableViewCelldelegate {
    func didTapFollowUnfollowButton(model: UserNotification) {
        print("tapped button")
        //perform database update
    }
    
   
    
    
    
}
