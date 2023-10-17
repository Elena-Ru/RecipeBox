//
//  RecipeImageCell.swift
//  RecipeBox
//
//  Created by Елена Русских on 2023-10-17.
//

import UIKit
import SnapKit

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
        addSubviews()
        activateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(recipeImageView)
    }
  
    private func activateConstraints() {
        recipeImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}
