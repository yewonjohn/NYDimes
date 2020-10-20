//
//  NYButton.swift
//  NYDimes
//
//  Created by John Kim on 10/14/20.
//

import UIKit

class NYButton: UIButton{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    
    private func setupButton() {
        backgroundColor     = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        titleLabel?.font    = .button
        layer.cornerRadius  = frame.size.height/3
        setTitleColor(.white, for: .normal)
    }
}
