//
//  EditprofileViewController.swift
//  Instagram
//
//  Created by Namrata Akash on 12/04/21.
//

import UIKit

struct editProfileFormModel {
    let label:String
    let placeholder:String
    var value:String?
}
final class EditprofileViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    private let tableview: UITableView = {
     let tableview = UITableView()
        tableview.register(FormTableViewCell.self, forCellReuseIdentifier: "FormTableViewCell")
        return tableview
    }()
    public var models = [[editProfileFormModel]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        view.addSubview(tableview)
        tableview.tableHeaderView = createtableheaderview()
        tableview.delegate = self
        tableview.dataSource = self
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didtapsave))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didtapcancel))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableview.frame = view.bounds
    }
   private func configureModels()  {
    // name user name website bio
    
    let labelsection1 = ["Name","Username","Bio"]
    var section1 = [editProfileFormModel]()
    for label in labelsection1 {
        let model = editProfileFormModel(label: label, placeholder: "Enter\(label)...", value: nil)
        section1.append(model)
    }
    models.append(section1)
    //email phonenumber gender DOB
    let labelsection2 = ["Email","Phone numver","Gender"]
    var section2 = [editProfileFormModel]()
    for label in labelsection2 {
        let model = editProfileFormModel(label: label, placeholder: "Enter\(label)...", value: nil)
        section2.append(model)
    }
    models.append(section2)
    }
    
    @objc private func didtapsave()
    {
       // save into database
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didtapcancel()
    {
        dismiss(animated: true, completion: nil)
        
    }
    @objc private func didtapeditprofilepic()
    {
        let actionsheet = UIAlertController(title: "Profile Picture", message: "Change Profile Picture", preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            }))
        actionsheet.addAction(UIAlertAction(title: "Choose from Gallary", style: .default, handler: { _ in
            }))
        actionsheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
        
        actionsheet.popoverPresentationController?.sourceView = view
        actionsheet.popoverPresentationController?.sourceRect = view.bounds
        present(actionsheet, animated: true)
    }
    // MARK : - Tableview
    private func createtableheaderview() -> UIView {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height:view.height/4).integral)
        let size = header.height/1.5
        let profilephotobutton = UIButton(frame: CGRect(
                                            x: (view.width - size)/2,
                                            y: (header.height-size)/2,
                                            width: size,
                                            height: size))
        header.addSubview(profilephotobutton)
        profilephotobutton.addTarget(self, action: #selector(didtapprofilephotobutton), for: .touchUpInside)
        profilephotobutton.setBackgroundImage(UIImage(systemName: "person.fill"), for: .normal)
        profilephotobutton.tintColor = .label
        profilephotobutton.layer.borderWidth = 1
        profilephotobutton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        profilephotobutton.layer.masksToBounds = true
        profilephotobutton.layer.cornerRadius = size/2.0
        return header
    }
    
    @objc private func didtapprofilephotobutton()
    {
         
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section][indexPath.row]
        let cell = tableview.dequeueReusableCell(withIdentifier: "FormTableViewCell", for: indexPath) as! FormTableViewCell
        cell.delegate = self
        cell.configure(with: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else {
            return nil
        }
        return "Private information"
    }
    }
  
// extension
extension EditprofileViewController:FormTableViewCellDelegate
{
    func formtableviewcell(_ cell: FormTableViewCell, didupdatefield updatedmodel: editProfileFormModel) {
        print(updatedmodel.value ?? "nil")
    }
    
    
}
