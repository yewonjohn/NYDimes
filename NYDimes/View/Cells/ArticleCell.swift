//
//  ArticleCell.swift
//  NYDimes
//
//  Created by John Kim on 10/18/20.
//

import UIKit

class ArticleCell: UICollectionViewCell{
    
    static let identifier = "ArticleCell"
    private let saveClicked = false
    
     let articleImage = UIImageView()
    private let articleTitle = UILabel()
    private let gradientView = GradientImageView(colors: [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)], gradientDirection: .upDown)
    let saveButton = UIButton()
    private let authorLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
//        configureButton()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configureImage(with image: UIImage){
        contentView.addSubview(articleImage)
        articleImage.image = image
        articleImage.contentMode = .scaleAspectFill
        articleImage.frame = contentView.bounds
        configureGradient()
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
    
    func configureTitle(with text: String){
        articleImage.addSubview(articleTitle)
        articleTitle.text = text
        articleTitle.font = .articleTitle
        articleTitle.textColor = .articleTitle
        articleTitle.numberOfLines = 0
        articleTitle.textAlignment = .left
        
        articleTitle.translatesAutoresizingMaskIntoConstraints = false

        articleTitle.leadingAnchor.constraint(equalTo: articleImage.leadingAnchor, constant: 7).isActive = true
        articleTitle.trailingAnchor.constraint(equalTo: articleImage.trailingAnchor).isActive = true
        articleTitle.topAnchor.constraint(equalTo: articleImage.topAnchor, constant: 6).isActive = true
    }
    
    func configureButton(){
        articleImage.addSubview(saveButton)
        saveButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        saveButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
//        saveButton.backgroundImage(for: .normal)?.withTintColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
//        saveButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(saveButtonClicked))
        saveButton.isUserInteractionEnabled = true
        saveButton.addGestureRecognizer(singleTap)
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.trailingAnchor.constraint(equalTo: articleImage.trailingAnchor, constant: -5).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: articleImage.bottomAnchor, constant: -5).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
    }
    
    func configureAuthors(authors: String){
        articleImage.addSubview(authorLabel)
        authorLabel.text = authors
        authorLabel.font = .authors
        authorLabel.textColor = .authors
        authorLabel.numberOfLines = 0
        authorLabel.textAlignment = .left
        
        authorLabel.translatesAutoresizingMaskIntoConstraints = false

        authorLabel.leadingAnchor.constraint(equalTo: articleImage.leadingAnchor, constant: 7).isActive = true
        authorLabel.trailingAnchor.constraint(equalTo: saveButton.leadingAnchor, constant: -3).isActive = true
        authorLabel.bottomAnchor.constraint(equalTo: articleImage.bottomAnchor, constant: -5).isActive = true
    }
    //MARK:-- Animation Config
    func pulse(button: UIButton){
        if(!saveClicked){
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
        }else{
            UIView.animate(withDuration: 2.0,
              delay: 0,
              usingSpringWithDamping: 0.2,
              initialSpringVelocity: 6.0,
              options: .allowUserInteraction,
              animations: {
                button.transform = .identity
                button.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
              },
              completion: nil)
        }

    }
    
    //MARK:-- User Interaction
    @objc private func saveButtonClicked(){
        print("button Clicked")
        pulse(button: saveButton)
    }
    
//    override func layoutIfNeeded() {
//        super.layoutIfNeeded()
//        imageView.frame = contentView.bounds
//    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        articleImage.image = nil
//    }
    
}
