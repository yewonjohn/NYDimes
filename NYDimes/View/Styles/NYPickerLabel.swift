//
//  NYPickerLabel.swift
//  NYDimes
//
//  Created by John Kim on 10/20/20.
//
import UIKit

class NYPickerLabel: UILabel{
    
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
        font = .pickerLabel
        textAlignment = .center
    }
    
}
