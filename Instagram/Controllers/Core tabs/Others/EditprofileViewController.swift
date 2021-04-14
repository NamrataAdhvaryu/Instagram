//
//  EditprofileViewController.swift
//  Instagram
//
//  Created by Namrata Akash on 12/04/21.
//

import UIKit

class EditprofileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didtapsave))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didtapcancel))
    }
    
    @objc private func didtapsave()
    {
        
        
    }
    
    @objc private func didtapcancel()
    {
        
        
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
}
