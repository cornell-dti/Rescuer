//
//  EditTableViewCell.swift
//  ResCUer
//
//  Created by Matthew Barker on 11/11/16.
//  Copyright © 2016 Raymone Radi . All rights reserved.
//

import UIKit

class EditTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    var mode: String!
    var dialPad: Bool = false
    var placeholder: String!
    var textfield: UITextField!
    var accessory: UIToolbar!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        textfield = UITextField(frame: contentView.frame)
        textfield.frame.size.width = UIScreen.main.bounds.width - 20
        textfield.delegate = self
        textfield.borderStyle = .none
        textfield.clearButtonMode = .whileEditing
        textfield.textAlignment = .right
        textfield.textColor = UIColor.black.withAlphaComponent(0.75)
        contentView.addSubview(textfield)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        print("Something bad happened"); fatalError("init(coder:) has not been implemented")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        contentView.endEditing(true)
        self.setSelected(false, animated: true)
        return true //save()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if dialPad { textfield.keyboardType = .phonePad }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField == self.textfield) {
            let oldString = textField.text!
            let newStart = oldString.index(oldString.startIndex, offsetBy: range.location)
            let newEnd = oldString.index(oldString.startIndex, offsetBy: range.location + range.length)
            let newString = oldString.replacingCharacters(in: newStart..<newEnd, with: string)
            textField.text = newString.replacingOccurrences(of: " ", with: "\u{00a0}")
            return false;
        } else { return true }
    }
    
}
