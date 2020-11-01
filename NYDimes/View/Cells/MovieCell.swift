//
//  MovieCell.swift
//  NYDimes
//
//  Created by John Kim on 10/31/20.
//

import UIKit

class MovieCell : UICollectionViewCell {
    
    static let identifier = "MovieCell"
    
    //MARK:-- Properties
    var movieTitle = UILabel()
    var movieDescription = UILabel()
    var movieImage = UIImageView()
    let gradientView = GradientImageView(colors: [#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)], gradientDirection: .downUp)
    var moviePublished = UILabel()
    

    var imageURL : String? {
        didSet{
            setImage(url: imageURL ?? "")
        }
    }
    
    //MARK:- LifeCycle Methods

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureImage()
        configureGradient()
        configTitle()
        configureDescription()
        configurePublished()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        articleImage.image = nil
    }
    
    //MARK:-- Configuration Methods
    
    func configureImage(){
        contentView.addSubview(movieImage)

        movieImage.contentMode = .scaleAspectFill
        movieImage.frame = contentView.bounds
        configureGradient()
    }
    
    func setImage(url: String){
        let url = URL(string: url)
        movieImage.kf.setImage(with: url)
    }
    
    func configureGradient(){
        movieImage.addSubview(gradientView)
        gradientView.contentMode = .scaleAspectFill
        gradientView.alpha = 0.5
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.centerXAnchor.constraint(equalTo: movieImage.centerXAnchor).isActive = true
        gradientView.centerYAnchor.constraint(equalTo: movieImage.centerYAnchor).isActive = true
        gradientView.widthAnchor.constraint(equalTo: self.movieImage.widthAnchor, multiplier: 1.0).isActive = true
        gradientView.heightAnchor.constraint(equalTo: self.movieImage.heightAnchor, multiplier: 1.0).isActive = true
    }
    
    func configTitle(){
        movieImage.addSubview(movieTitle)
        movieTitle.translatesAutoresizingMaskIntoConstraints = false
        movieTitle.font = .movieTitle
        movieTitle.textColor = .movieTitle
        movieTitle.numberOfLines = 0
        
        movieTitle.topAnchor.constraint(equalTo: movieImage.topAnchor, constant: 5).isActive = true
        movieTitle.leadingAnchor.constraint(equalTo: movieImage.leadingAnchor, constant: 5).isActive = true
        movieTitle.trailingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: -5).isActive = true
    }
    
    func configureDescription(){
        movieImage.addSubview(movieDescription)
        
        movieDescription.translatesAutoresizingMaskIntoConstraints = false
        movieDescription.font = .movieDescription
        movieDescription.textColor = .movieDescription
        movieDescription.numberOfLines = 0
        movieDescription.textAlignment = .left
        
        movieDescription.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 5).isActive = true
        movieDescription.leadingAnchor.constraint(equalTo: movieImage.leadingAnchor, constant: 5).isActive = true
        movieDescription.trailingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: -5).isActive = true
        
    }
    
    func configurePublished(){
        movieImage.addSubview(moviePublished)
        
        moviePublished.translatesAutoresizingMaskIntoConstraints = false
        moviePublished.font = .movieDescription
        moviePublished.textColor = .movieDescription
        moviePublished.numberOfLines = 0
        moviePublished.textAlignment = .left
        
        moviePublished.bottomAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: -5).isActive = true
        moviePublished.leadingAnchor.constraint(equalTo: movieImage.leadingAnchor, constant: 5).isActive = true
        moviePublished.trailingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: -5).isActive = true
    }
    
    
}

