//
//  ViewController.swift
//  Instagram
//
//  Created by Namrata Akash on 12/04/21.
//

import UIKit
import FirebaseAuth


struct HomefeedRenderViewModel {
    let header:PostRenderViewModel
    let post:PostRenderViewModel
    let actions:PostRenderViewModel
    let comments:PostRenderViewModel
}
class HomeViewController: UIViewController {
    
    private var feedRenderModels = [HomefeedRenderViewModel]()
    
    
    private var tableview:UITableView = {
        let tableview = UITableView()
        tableview.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier:IGFeedPostTableViewCell.identifier)
        tableview.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier:IGFeedPostHeaderTableViewCell.identifier)
        tableview.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier:IGFeedPostGeneralTableViewCell.identifier)
        tableview.register(IGFeedPostActionsTableViewCell.self, forCellReuseIdentifier:IGFeedPostActionsTableViewCell.identifier)
        return tableview
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        createMockModels()
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
    
    private func createMockModels() {
        let user = User(username: "namrata", bio: "", profilpicture: URL(string: "http://www.google.com")!, name: (first: "", last: ""), birthdate: Date(), gender: .female, counts: Usercount(following: 1, follwers: 1, posts: 1), joinDate: Date())
        let post = userPost(identifier: "", postType: .photo, thumbnailimage: URL(string: "http://www.google.com")!, postURL: URL(string: "http://www.google.com")!, caption: "", likecount: [], commnents: [], createddate: Date(), taggedUsers: [],owner:user)
        var comments = [Postcomments]()
        for x in 0..<2 {
            comments.append(Postcomments(identifier: "\(x)", username: "akash", text: "this is the best picture i have ever seen", createddate: Date(), likes: []))
            
        }
        for x in 0..<5 {
            let viewmodel = HomefeedRenderViewModel(
                header: PostRenderViewModel(renderType: .header(Provider: user)) ,
                post: PostRenderViewModel(renderType: .primaryContent(Provider: post)),
                actions: PostRenderViewModel(renderType: .actions(provider: "")),
                comments: PostRenderViewModel(renderType: .comments(comments: comments)))
            feedRenderModels.append(viewmodel)
        }
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
        return feedRenderModels.count * 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let x = section
        let model:HomefeedRenderViewModel
        if x == 0 {
            model = feedRenderModels[0]
        }
        else {
            let position = x % 4 == 0 ? x/4 : ((x - (x % 4)) / 4)
            model = feedRenderModels[position]
        }
        
        let subSection = x % 4
        
        if subSection == 0 {
            // header
            return 1
        }
        else if subSection == 1 {
            //post
            return 1
        }
        else if subSection == 2 {
            //actions
            return 1
        }
        else if subSection == 3 {
            //comments
            let commentmodel = model.comments
            switch commentmodel.renderType {
            case .comments(let comments): return comments.count > 2 ? 2 : comments.count
            case .header , .actions , .primaryContent: return 0
            
                
            }
        }
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let x = indexPath.section
        let model:HomefeedRenderViewModel
        if x == 0 {
            model = feedRenderModels[0]
        }
        else {
            let position = x % 4 == 0 ? x/4 : ((x - (x % 4)) / 4)
            model = feedRenderModels[position]
        }
        
        let subSection = x % 4
        
        if subSection == 0 {
            // header
            let headermodel = model.header
            switch headermodel.renderType {
            case .header(let user):
                let cell = tableview.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier, for: indexPath) as! IGFeedPostHeaderTableViewCell
                
                return cell
            case .comments , .actions , .primaryContent: return UITableViewCell()
                
            }
        }
        else if subSection == 1 {
            //post
            let postmodel = model.post
            switch postmodel.renderType {
            case .primaryContent(let post):
                let cell = tableview.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
                
                return cell
            case .comments , .actions , .header: return UITableViewCell()
                
            }
        }
        else if subSection == 2 {
            //actions
            let actionmodel = model.actions
            switch actionmodel.renderType {
            case .actions(let provider):
                let cell = tableview.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier, for: indexPath) as! IGFeedPostActionsTableViewCell
                
                return cell
            case .comments , .primaryContent , .header: return UITableViewCell()
                
            }
        }
        else if subSection == 3 {
            //comments
            let commentmodel = model.comments
            switch commentmodel.renderType {
            case .comments(let comments):
                let cell = tableview.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier, for: indexPath) as! IGFeedPostGeneralTableViewCell
                
                return cell
            case .primaryContent , .actions , .header: return UITableViewCell()
            }
        }
        return UITableViewCell()
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let subsection = indexPath.section % 4
        if subsection == 0 {
            //header
            return 70
        }
        else if subsection == 1 {
            //post
            return tableview.width
        }
        else if subsection == 2 {
            //action (like /comment)
            return 60
        }
        else if subsection == 3 {
            //commentrow
            return 50
        }
        
        return 0
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let subsection = section % 4
        return subsection == 3 ? 70 : 0
    }
}
