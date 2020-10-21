//
//  Animations.swift
//  NYDimes
//
//  Created by John Kim on 10/20/20.
//

import UIKit

struct Animations{
    
    //MARK:-- Animation Config
    func pulse(button: UIButton){
//        if(!saveClicked){
//            saveClicked = true
            button.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)

            UIView.animate(withDuration: 2.0,
              delay: 0,
              usingSpringWithDamping: 0.2,
              initialSpringVelocity: 6.0,
              options: .allowUserInteraction,
              animations: {
                button.transform = .identity
                button.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
              },
              completion: nil)
//        }else{
//            saveClicked = false
//            button.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
//
//            UIView.animate(withDuration: 2.0,
//              delay: 0,
//              usingSpringWithDamping: 0.2,
//              initialSpringVelocity: 6.0,
//              options: .allowUserInteraction,
//              animations: {
//                button.transform = .identity
//                button.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
//              },
//              completion: nil)
//        }
    }

    
}
