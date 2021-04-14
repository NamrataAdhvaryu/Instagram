//
//  SettingsViewController.swift
//  Instagram
//
//  Created by Namrata Akash on 12/04/21.
//
import SafariServices
import UIKit
struct SettingCellModel {
    let title:String
    let handler: (() -> Void)
}
class SettingsViewController: UIViewController {
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigureModels()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    private var data = [[SettingCellModel]]()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    private func ConfigureModels()
    {
        data.append([
            SettingCellModel(title: "Edit Profile") { [weak self] in
                self?.didtapeditprofile()
            },
            SettingCellModel(title: "Invite Friends") { [weak self] in
                self?.didtapinvitefriends()
            },
            SettingCellModel(title: "Save Original Posts") { [weak self] in
                self?.didtapsaveoriginalposts()
            }
            
        ])
        data.append([
            SettingCellModel(title: "Terms and Services") { [weak self] in
                self?.openURL(type: .terms)
            },
            SettingCellModel(title: "Privacy and Policy") { [weak self] in
                self?.openURL(type: .privacy)
            },
            SettingCellModel(title: "Help / Feedback") { [weak self] in
                
                self?.openURL(type: .help)
                
            }
            
        ])
        
        
        data.append([
            SettingCellModel(title: "Log out") { [weak self] in
                
                self!.didtaplogout()
                
            }
            
        ])
        
        
        
        
        
        
    }
    enum settingurlType
    {
        case privacy,terms,help
    }
    func  openURL(type: settingurlType) {
        let urlstring: String
        switch type {
        case .privacy:urlstring = "https://help.instagram.com/519522125107875"
        case .terms: urlstring = "https://www.instagram.com/about/legal/terms/before-january-19-2013/"
        case .help: urlstring = "https://help.instagram.com/"
        }
        
        guard let url = URL(string: urlstring) else {
            return
        }
        let vc = SFSafariViewController(url: url)
        vc.present(vc, animated: true)
    }
    func didtapeditprofile() {
        let vc = EditprofileViewController()
        vc.title = "Edit Profile"
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
        
    }
    func didtapinvitefriends() {
        
    }
    func didtapsaveoriginalposts() {
        
    }
    
    func didtaplogout()
    {
        
        let actionsheet = UIAlertController(title: "Log Out", message: "Are you sure you want to logout?", preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionsheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
            AuthManager.shared.Logout(completion: { sucess in
                
                DispatchQueue.main.async {
                    if sucess {
                        let loginVC = LoginViewController()
                        loginVC.modalPresentationStyle = .fullScreen
                        self.present(loginVC, animated: false) {
                            
                            self.navigationController?.popToRootViewController(animated: false)
                            self.tabBarController?.selectedIndex = 0
                        }
                    }
                    else {
                        fatalError("could not log out user")
                    }
                }
                
            })
            
            
        }))
        actionsheet.popoverPresentationController?.sourceView = tableView
        actionsheet.popoverPresentationController?.sourceRect = tableView.bounds
        present(actionsheet, animated: true)
        
    }
}
extension SettingsViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = data[indexPath.section][indexPath.row]
        model.handler()
    }
}
