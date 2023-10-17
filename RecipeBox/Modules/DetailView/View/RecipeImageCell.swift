//
//  RecipeImageCell.swift
//  RecipeBox
//
//  Created by Елена Русских on 2023-10-17.
//

import UIKit

class RecipeImageCell: UICollectionViewCell {
    static let identifier = "RecipeImageCell"
    
    var recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(recipeImageView)
        
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: topAnchor),
            recipeImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            recipeImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            recipeImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

}
