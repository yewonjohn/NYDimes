//
//  NYTextField.swift
//  NYDimes
//
//  Created by John Kim on 10/18/20.
//

import UIKit

class NYTextField: UITextField{
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setUpField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpField()
    }
    
    func setUpField(){
        tintColor = .white
        textColor = .fieldColor
        font = .textField
        backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        autocorrectionType = .no
        layer.cornerRadius = frame.size.height/3
        clipsToBounds = true
        
        let placeholder       = self.placeholder != nil ? self.placeholder! : ""
        let placeholderFont   = font
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes:
            [NSAttributedString.Key.foregroundColor: UIColor.lightGray,
             NSAttributedString.Key.font: placeholderFont])
        
        let indentView        = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        leftView              = indentView
        leftViewMode          = .always
    }
    
}
