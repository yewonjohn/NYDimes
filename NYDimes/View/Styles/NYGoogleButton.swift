//
//  NYGoogleButton.swift
//  NYDimes
//
//  Created by John Kim on 10/19/20.
//

import UIKit
import GoogleSignIn

class NYGoogleButton: GIDSignInButton{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton(){
        layer.cornerRadius  = frame.size.height/4
        style = .wide

    }
    
    
}
