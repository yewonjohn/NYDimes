//
//  SavedCell.swift
//  NYDimes
//
//  Created by John Kim on 10/20/20.
//

import UIKit
import SwipeCellKit

class SavedCell: SwipeTableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleAuthor: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: 0).isActive = true
        
        articleImage.layer.cornerRadius = 4
        articleImage.clipsToBounds = true
        
        articleTitle.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 4).isActive = true
        articleAuthor.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 4).isActive = true

        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
