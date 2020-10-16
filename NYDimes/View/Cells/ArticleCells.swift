//
//  ArticleCells.swift
//  NYDimes
//
//  Created by John Kim on 10/15/20.
//

import UIKit

class ArticleCells: UICollectionViewCell{
    
    fileprivate let articleTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font =
        label.text = "How to Article 101"
        label.textColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        label.textAlignment = .center
        
        return label
    }()
    
    
    
    
    
    
    
    
    
}
