//
//  NYSearchButton.swift
//  NYDimes
//
//  Created by John Kim on 10/20/20.
//

import UIKit

class NYSearchButton: UIButton{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    
    private func setupButton() {
        backgroundColor     = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        titleLabel?.font    = .guestButton
        layer.cornerRadius  = frame.size.height/3
        setTitleColor(.darkGray, for: .normal)
        
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
//        layer.masksToBounds = false
////        layer.shadowRadius = 2.0
//        layer.shadowOpacity = 0.2
//        layer.cornerRadius = pressButton.frame.width / 2
        layer.borderColor = UIColor.darkGray.cgColor
        layer.borderWidth = 1.0
        
    }
}
