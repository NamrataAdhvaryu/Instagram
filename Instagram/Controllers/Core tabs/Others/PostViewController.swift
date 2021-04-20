//
//  PostViewController.swift
//  Instagram
//
//  Created by Namrata Akash on 12/04/21.
//

import UIKit
/*
 section
 Header model
 section
 Post cell model
 section
 Action button cell model
 setion
 n number of general model for comments
 */
//states of a rendered cell
enum PostRenderType {
    case header(Provider:User)
    case primaryContent(Provider:userPost) //post
    case actions(provider:String)// like,comment,share
    case comments(comments:[Postcomments])
}
//model of render post
struct PostRenderViewModel {
    let renderType:PostRenderType
}
class PostViewController: UIViewController {
   private var rendermodels = [PostRenderViewModel]()
    private let model : userPost?
    private let tableview : UITableView = {
      let tableview = UITableView()
        tableview.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier:IGFeedPostTableViewCell.identifier)
        tableview.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier:IGFeedPostHeaderTableViewCell.identifier)
        tableview.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier:IGFeedPostGeneralTableViewCell.identifier)
        tableview.register(IGFeedPostActionsTableViewCell.self, forCellReuseIdentifier:IGFeedPostActionsTableViewCell.identifier)
        
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
    configuremodels()
    view.backgroundColor = .systemBackground
    view.addSubview(tableview)
    tableview.delegate = self
    tableview.dataSource = self
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableview.frame = view.bounds
    }
    
   private func configuremodels() {
    guard let userPostmodel = self.model else {
        return
    }
    //header
    rendermodels.append(PostRenderViewModel(renderType: .header(Provider: userPostmodel.owner)))
    //post
    rendermodels.append(PostRenderViewModel(renderType: .primaryContent(Provider: userPostmodel)))
    //actions
    rendermodels.append(PostRenderViewModel(renderType: .actions(provider: "")))
    //4 comments
    var comments = [Postcomments]()
    for x in 0..<4 {
        comments.append(Postcomments(identifier: "123_\(x)", username: "namrata", text: "great post!", createddate: Date(), likes: []))
    }
    rendermodels.append(PostRenderViewModel(renderType: .comments(comments: comments )))
   }
    
}
extension PostViewController:UITableViewDelegate,UITableViewDataSource  {
    func numberOfSections(in tableView: UITableView) -> Int {
        return rendermodels.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch rendermodels[section].renderType {
        case .actions(_): return 1
        case .comments(let comments): return comments.count > 4 ? 4: comments.count
        case .primaryContent(_): return 1
        case .header(_): return 1
        
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = rendermodels[indexPath.section]
        switch model.renderType {
        case .actions(let action):
            let cell = tableview.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier, for: indexPath) as! IGFeedPostActionsTableViewCell
            
            return cell
        case .comments(let comments):
            let cell = tableview.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier, for: indexPath) as! IGFeedPostGeneralTableViewCell
            
            return cell
        case .primaryContent(let post):
            let cell = tableview.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
            
            return cell
        case .header(let user):
            let cell = tableview.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier, for: indexPath) as! IGFeedPostHeaderTableViewCell
            
            return cell
    }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = rendermodels[indexPath.section]
        switch model.renderType {
        case .actions(_): return 60
        case .comments(_): return 50
        case .primaryContent(_): return tableview.width
        case .header(_): return 70
    }
    }
}
