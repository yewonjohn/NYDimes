//
//  ArticleCells.swift
//  NYDimes
//
//  Created by John Kim on 10/15/20.
//

import UIKit

class ArticleCells: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        containerView.layer.cornerRadius = 5
        containerView.clipsToBounds = true
        
        titleLabel.text = "Something Here"
        
        imageView.image = #imageLiteral(resourceName: "exampleBackground2")
        
    }

}
