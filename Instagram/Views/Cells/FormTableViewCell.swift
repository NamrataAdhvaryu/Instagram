//
//  FormTableViewCell.swift
//  Instagram
//
//  Created by Namrata Akash on 15/04/21.
//

import UIKit
protocol FormTableViewCellDelegate:AnyObject {
    func formtableviewcell(_ cell: FormTableViewCell,didupdatefield updatedmodel: editProfileFormModel)

    
}
class FormTableViewCell: UITableViewCell,UITextFieldDelegate {
    public var delegate:FormTableViewCellDelegate?
    public let identifier = "FormTableViewCell"
    private let label:UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        
        return label
    }()
    private let textfield:UITextField = {
     let textfield = UITextField()
        textfield.returnKeyType = .done
        return textfield
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        contentView.addSubview(textfield)
        contentView.addSubview(label)
        textfield.delegate = self
        selectionStyle = .none
    }
    private var model:editProfileFormModel?
    
    public func configure(with model:editProfileFormModel)
    {
        self.model = model
        label.text = model.label
        textfield.placeholder = model.placeholder
        textfield.text = model.value
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        textfield.placeholder = nil
        textfield.text = nil
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //frames
        label.frame = CGRect(
            x: 5,
            y: 0,
            width: contentView.width/3,
            height: contentView.height)
        textfield .frame = CGRect(
            x: label.right + 5,
            y: 0,
            width: contentView.width-10-label.width,
            height: contentView.height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - textfield methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        model?.value = textfield.text
        guard let model = model else {
            return true
        }
        delegate?.formtableviewcell(self, didupdatefield: model)
        textfield.resignFirstResponder()
        return true
    }
}



