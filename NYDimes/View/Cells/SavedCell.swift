//
//  SavedCell.swift
//  NYDimes
//
//  Created by John Kim on 10/20/20.
//

import UIKit
import SwipeCellKit

class SavedCell: SwipeTableViewCell {
    //MARK:- Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleAuthor: UILabel!
    //MARK:- Properties
    static let identifier = "SavedCell"
    private let gradientView = GradientImageView(colors: [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)], gradientDirection: .upDown)
    //MARK:- Lifecycle Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureLayout()
        configureGradient()
    }  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //MARK:- Layout Config
    
    func configureLayout(){
        containerView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: 0).isActive = true
        
        articleImage.layer.cornerRadius = 4
        articleImage.clipsToBounds = true
        
        articleTitle.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 4).isActive = true
        articleAuthor.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 4).isActive = true
    }

    func configureGradient(){
        articleImage.addSubview(gradientView)
        gradientView.contentMode = .scaleAspectFill
        gradientView.alpha = 0.5
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.centerXAnchor.constraint(equalTo: articleImage.centerXAnchor).isActive = true
        gradientView.centerYAnchor.constraint(equalTo: articleImage.centerYAnchor).isActive = true
        gradientView.widthAnchor.constraint(equalTo: self.articleImage.widthAnchor, multiplier: 1.0).isActive = true
        gradientView.heightAnchor.constraint(equalTo: self.articleImage.heightAnchor, multiplier: 1.0).isActive = true
    }

    
}
