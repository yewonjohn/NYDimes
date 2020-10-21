//
//  NYPickerTitleLabel.swift
//  NYDimes
//
//  Created by John Kim on 10/21/20.
//

import UIKit

class NYPickerTitleLabel: UILabel{
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setUpField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpField()
    }
    
    func setUpField(){
        textColor = .pickerLabel
        font = .pickerTitleLabel
        textAlignment = .center
    }
    
}
