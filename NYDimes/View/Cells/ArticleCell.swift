//
//  ArticleCell.swift
//  NYDimes
//
//  Created by John Kim on 10/18/20.
//

import UIKit

class ArticleCell: UICollectionViewCell{
    
    static let identifier = "ArticleCell"
    private let viewModel = ArticlesViewModel()
    var article : ArticleModel?
//    private var saveClicked = false

    let articleImage = UIImageView()
    private let articleTitle = UILabel()
    private let gradientView = GradientImageView(colors: [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)], gradientDirection: .upDown)
    let saveButton = UIButton()
    private let authorLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
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
        saveButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        saveButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.trailingAnchor.constraint(equalTo: articleImage.trailingAnchor, constant: -5).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: articleImage.bottomAnchor, constant: -5).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        saveButton.addTarget(self, action: #selector(saveButtonClicked(button:)), for: .touchUpInside)

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
    
    //MARK:-- User Interaction
    @objc func saveButtonClicked(button: UIButton){
        guard let article = article else {return}
        viewModel.saveArticle(article: article)
        Animations().pulse(button: button)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard isUserInteractionEnabled else { return nil }
        guard !isHidden else { return nil }
        guard alpha >= 0.01 else { return nil }
        guard self.point(inside: point, with: event) else { return nil }
        
        // add one of these blocks for each button in our collection view cell we want to actually work
        if self.saveButton.point(inside: convert(point, to: saveButton), with: event) {
            return self.saveButton
        }
        return super.hitTest(point, with: event)
    }
    
//    override func layoutIfNeeded() {
//        super.layoutIfNeeded()
//        imageView.frame = contentView.bounds
//    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        articleImage.image = nil
    }
    
}
